/* Main source file of hWexla ATmega CPU.
 */

#include <stdint.h>
#include <stdbool.h>
#include <util/delay.h>
#include <avr/interrupt.h>
#include <avr/io.h>
#include <avr/wdt.h>
#include <avr/eeprom.h>
#include <avr/boot.h>
#include <util/atomic.h>
#include <stdlib.h>

#include "io.h"
#include "pwm_servo_gen.h"
#include "switch.h"
#include "inputs.h"
#include "eeprom.h"
#include "usart.h"
#include "diag.h"

///////////////////////////////////////////////////////////////////////////////

int main();
static void init(void);
static void set_outputs(void);
static void programming_enter(void);
static void programming_leave(void);
static void init_done(void);
static void leds_update(void);
static void inputs_poll(void);
bool magnet_isclose(uint16_t value, uint8_t threshold);

///////////////////////////////////////////////////////////////////////////////

#define BTN_FLICK_PERIOD 150 // ms (max uint8_t)
#define LED_FLICK_PERIOD 500 // ms (max uint16_t)
#define LED_FLICK_ON 250 // ms
#define PROG_BTN_MAX 20 // ms
#define INIT_ADC_VCC_LIMIT 5 // cca 250 ms
#define DIAG_UPDATE_PERIOD 200 // 200 ms
#define WARN_IND_MAX 10000 // 10 s
#define WARN_IND_BEGIN 9000

FailCode fail_code = fNoFail;
Warnings warnings;

volatile Turnout turnout;
volatile Mode mode;

volatile bool btn_flick = false;
volatile uint8_t prog_btn_counter_ms = 0;
volatile uint8_t pseudorand = 0;
uint8_t init_adc_vcc_ok_count = 0;
uint8_t init_adc_vcc_nok_count = 0;
volatile uint8_t diag_counter = 0;
volatile bool isr_switch_update_req = false;
volatile uint16_t led_flick_counter = 0; // note: read in ATOMIC_BLOCK!
volatile uint16_t warn_ind_counter = 0; // warning indication on outputs; note: read in ATOMIC_BLOCK!

///////////////////////////////////////////////////////////////////////////////

int main() {
	init();

	while (true) {
		inputs_update();
		inputs_poll();
		adc_poll();
		warnings.sep.magnet = magnet_iswarn();
		diag_read();
		leds_update();
		set_outputs();

		if (isr_switch_update_req) {
			switch_update();
			isr_switch_update_req = false;
		}

		// Saving to EEPROM can take a really long time -> save only if eeprom is ready
		if (ee_to_save) {
			if (ee_save()) {
				ee_to_save = false;
				ee_to_save_servo_vcc = false;
			}
		}
		else if (ee_to_save_servo_vcc) {
			if (ee_save_servo_vcc())
				ee_to_save_servo_vcc = false;
		}
		else if (ee_to_save_pos_plus) {
			if (ee_save_pos_plus())
				ee_to_save_pos_plus = false;
		}
		else if (ee_to_save_pos_minus) {
			if (ee_save_pos_minus())
				ee_to_save_pos_minus = false;
		}

		if (diag_counter >= DIAG_UPDATE_PERIOD) {
			diag_send();
			diag_counter = 0;
		}

		wdt_reset();
	}
}

void init(void) {
	ACSR |= ACD;  // analog comparator disable
	TIMSK = 0;
	mode = mInitializing;
	warnings.all = 0;

	io_init();
	set_output(PIN_LED_RED, true);
	set_output(PIN_LED_YELLOW, true);

	inputs_init();
	ee_load();
	pwm_servo_init();
	usart_initialize();

	bool reset_wanted = eeprom_read_byte(EEPROM_ADDR_RESET_WANTED);
	if ((((MCUCSR >> WDRF) & 1)) && (!reset_wanted)) {
		warnings.sep.wdg_reset = true;
		ee_to_save = true;
	}
	eeprom_update_byte(EEPROM_ADDR_RESET_WANTED, 0);

	// Timer 2 @ 1 kHz (1 ms)
	TCCR2 = (1 << WGM21) | (1 << CS21) | (1 << CS20); // CTC; prescaler 32×
	OCR2 = 248; // 1 ms
	TIMSK |= (1 << OCIE2);

	// Delay turning-on servo power for pseudorandom time
	uint8_t delay = (turnout.moved_plus % 10)+2; // 100-600 ms; step=50 ms
	for (size_t i = 0; i < delay; i++)
		_delay_ms(50);

	set_output(PIN_SERVO_POWER_EN, true);
	pwm_servo_gen(turnout.angle);

	if (mode == mFail) // failed during startup
		fail(fail_code); // fail again to reset outputs

	sei(); // enable interrupts globally
	wdt_enable(WDTO_60MS);
}

ISR(BADISR_vect) {
	fail(fBadISR);
}

///////////////////////////////////////////////////////////////////////////////

ISR(TIMER2_COMP_vect) {
	// Timer 2 @ 1 kHz (1 ms)
	// Execution on this timer taked ~100 us
	inputs_update_1ms();

	static uint8_t counter_20ms = 0;
	counter_20ms++;
	if (counter_20ms >= 20) {
		counter_20ms = 0;
		if ((isr_switch_update_req) && (mode != mFail))
			warnings.sep.missed_timer = true;
		isr_switch_update_req = true;
	}

	static uint8_t counter_50ms = 0;
	counter_50ms++;
	if (counter_50ms >= 50) {
		adc_start_measure();
		counter_50ms = 0;
	}

	static uint8_t flick_counter = 0;
	flick_counter++;
	if (flick_counter >= BTN_FLICK_PERIOD) {
		btn_flick = !btn_flick;
		flick_counter = 0;
	}

	if (prog_btn_counter_ms < 0xFF)
		prog_btn_counter_ms++;

	if (diag_counter < DIAG_UPDATE_PERIOD)
		diag_counter++;

	led_flick_counter++;
	if (led_flick_counter >= LED_FLICK_PERIOD)
		led_flick_counter = 0;

	warn_ind_counter++;
	if (warn_ind_counter > WARN_IND_MAX)
		warn_ind_counter = 0;

	pseudorand++;
}

///////////////////////////////////////////////////////////////////////////////

void on_switch_done(void) {
	if (turnout.position == tpPlus)
		ee_to_save_pos_plus = true;
	else
		ee_to_save_pos_minus = true;
}

void on_btn_pressed(uint8_t button) {
	switch (button) {
	case DEB_BTN:
		if (mode == mRun)
			programming_enter();
		else if (mode == mProgramming)
			programming_leave();
		else if (mode == mOverride)
			override_leave();
		else if (mode == mFail)
			reset();
		break;
	}
}

///////////////////////////////////////////////////////////////////////////////

void inputs_poll(void) {
	if (mode == mRun) {
		if ((in_debounced[DEB_IN_PLUS]) && (!in_debounced[DEB_IN_MINUS]))
			switch_turnout(tpPlus);
		if ((in_debounced[DEB_IN_MINUS]) && (!in_debounced[DEB_IN_PLUS]))
			switch_turnout(tpMinus);

		if ((!in_debounced[DEB_IN_PLUS]) && (!in_debounced[DEB_IN_MINUS])) {
			if ((in_debounced[DEB_BTN_PLUS]) && (!in_debounced[DEB_BTN_MINUS]))
				switch_turnout(tpPlus);
			if ((in_debounced[DEB_BTN_MINUS]) && (!in_debounced[DEB_BTN_PLUS]))
				switch_turnout(tpMinus);
		}

	} else if (mode == mProgramming) {
		if (prog_btn_counter_ms < PROG_BTN_MAX)
			return;

		if ((in_debounced[DEB_BTN_PLUS]) && (!in_debounced[DEB_BTN_MINUS])) {
			if (turnout.angle < PWM_ANGLE_MAX) {
				prog_btn_counter_ms = 0;
				turnout.angle += 1;
				pwm_servo_gen(turnout.angle);
			}
		}
		if ((in_debounced[DEB_BTN_MINUS]) && (!in_debounced[DEB_BTN_PLUS])) {
			if (turnout.angle > PWM_ANGLE_MIN) {
				prog_btn_counter_ms = 0;
				turnout.angle -= 1;
				pwm_servo_gen(turnout.angle);
			}
		}

	}
}

bool magnet_isclose(uint16_t value, uint8_t threshold) {
	return abs((int16_t)mag_value-(int16_t)value) < threshold;
}

bool magnet_iswarn(void) {
	if (turnout.position == tpPlus) {
		return !magnet_isclose(turnout.sensor_plus, MAG_THRESHOLD_WARN);
	}
	if (turnout.position == tpMinus) {
		return !magnet_isclose(turnout.sensor_minus, MAG_THRESHOLD_WARN);
	}
	return false;
}

void set_outputs(void) {
	bool my_plus = (turnout.position == tpPlus) && (magnet_isclose(turnout.sensor_plus, MAG_THRESHOLD_OK));
	bool my_minus = (turnout.position == tpMinus) && (magnet_isclose(turnout.sensor_minus, MAG_THRESHOLD_OK));

	bool warn_output_active;
	ATOMIC_BLOCK(ATOMIC_FORCEON) {
		warn_output_active = ((warnings.all > 0) && (warn_ind_counter >= WARN_IND_BEGIN));
	}

	if ((mode == mRun) || (mode == mOverride)) {
		set_output(PIN_OUT_PLUS, (my_plus && (get_input(PIN_SLAVE) || in_debounced[DEB_IN_PLUS])) || (warn_output_active));
		set_output(PIN_OUT_MINUS, (my_minus && (get_input(PIN_SLAVE) || in_debounced[DEB_IN_MINUS])) || (warn_output_active));
		set_output(PIN_BTN_PLUS_OUT, my_plus || (turnout.position == tpMovingToPlus && btn_flick));
		set_output(PIN_BTN_MINUS_OUT, my_minus || (turnout.position == tpMovingToMinus && btn_flick));
	} else {
		set_output(PIN_OUT_PLUS, mode == mFail);
		set_output(PIN_OUT_MINUS, mode == mFail);
		set_output(PIN_BTN_PLUS_OUT, mode == mFail); // needs to be false to read both buttons
		set_output(PIN_BTN_MINUS_OUT, mode == mFail); // needs to be false to read both buttons
	}

	// Do not use sensor value to allow relay switching without physical servo
	if (mode == mFail) {
		set_output(PIN_RELAY_CONTROL, false);
	} else {
		if (turnout.position == tpPlus)
			set_output(PIN_RELAY_CONTROL, RELAY_STATE_PLUS);
		else if (turnout.position == tpMinus)
			set_output(PIN_RELAY_CONTROL, !RELAY_STATE_PLUS);
	}
}

///////////////////////////////////////////////////////////////////////////////

void programming_enter(void) {
	if ((turnout.position != tpPlus) && (turnout.position != tpMinus))
		return; // allow programming entry only when not moving

	mode = mProgramming;
	pwm_servo_gen(turnout.angle);
}

void programming_leave(void) {
	mode = mRun;
	pwm_servo_stop();

	if (turnout.position == tpPlus) {
		turnout.angle_plus = turnout.angle;
		turnout.sensor_plus = mag_value;
	} else if (turnout.position == tpMinus) {
		turnout.angle_minus = turnout.angle;
		turnout.sensor_minus = mag_value;
	}

	ee_to_save = true;
}

void override_enter(void) {
	mode = mOverride;
	ee_to_save = true;
}

void override_leave(void) {
	mode = mRun;
	ee_to_save = true;
}

void init_done(void) {
	pwm_servo_stop();
	mode = (ee_mode() == 1) ? mOverride : mRun;
}

void fail(FailCode code) {
	set_output(PIN_LED_GREEN, false);
	set_output(PIN_LED_YELLOW, false);
	set_output(PIN_SERVO_POWER_EN, false);

	// Set IO as inputs to allow external voltage to be applied (protection & hardware fixing)
	pin_mode(PIN_SERVO_POWER_EN, INPUT);
	pin_mode(PIN_SERVO_PWM, INPUT);
	pin_mode(PIN_RELAY_CONTROL, INPUT);

	fail_code = code;
	mode = mFail;
	ee_fail(code);
}

void reset(void) {
	eeprom_update_byte(EEPROM_ADDR_RESET_WANTED, true);
	cli();
	while (true);
}

///////////////////////////////////////////////////////////////////////////////

void leds_update(void) {
	bool flick_on;
	ATOMIC_BLOCK(ATOMIC_FORCEON) {
		flick_on = (led_flick_counter < LED_FLICK_ON);
	}
	set_output(PIN_LED_GREEN, (mode == mRun) || (mode == mInitializing) ||
		(((mode == mProgramming) || (mode == mOverride)) && (flick_on)));
	set_output(PIN_LED_YELLOW, (flick_on) &&
		(((mode == mRun) && (warnings.all > 0)) || (mode == mOverride)));
	set_output(PIN_LED_RED, (mode == mFail) && (flick_on));
}

///////////////////////////////////////////////////////////////////////////////

void on_adc_done(void) {
	if (mode == mInitializing) {
		if ((servo_vcc_value >= SERVO_VCC_MIN) && (servo_vcc_value <= SERVO_VCC_MAX)) {
			init_adc_vcc_ok_count++;
			if (init_adc_vcc_ok_count >= INIT_ADC_VCC_LIMIT)
				init_done();
		} else {
			init_adc_vcc_ok_count = 0;
			init_adc_vcc_nok_count++;
			if (init_adc_vcc_nok_count >= INIT_ADC_VCC_LIMIT)
				fail(fInitServoVCC);
		}

	} else if (mode != mFail) {
		if ((servo_vcc_value < SERVO_VCC_MIN) || (servo_vcc_value > SERVO_VCC_MAX))
			fail(fServoVCC);

		if (servo_vcc_value < servo_vcc_recorded_min) {
			servo_vcc_recorded_min = servo_vcc_value;
			ee_to_save_servo_vcc = true;
		}
		if (servo_vcc_value > servo_vcc_recorded_max) {
			servo_vcc_recorded_max = servo_vcc_value;
			ee_to_save_servo_vcc = true;
		}

		if ((servo_vcc_value < SERVO_VCC_MIN_WARN) && (!warnings.sep.servo_vcc_low)) {
			warnings.sep.servo_vcc_low = true;
			ee_to_save = true;
		}
		if ((servo_vcc_value > SERVO_VCC_MAX_WARN) && (!warnings.sep.servo_vcc_high)) {
			warnings.sep.servo_vcc_high = true;
			ee_to_save = true;
		}
	}
}

///////////////////////////////////////////////////////////////////////////////
