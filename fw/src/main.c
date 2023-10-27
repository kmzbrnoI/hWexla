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
static inline void init(void);
static inline void set_outputs(void);
static inline void programming_enter(void);
static inline void programming_leave(void);
static inline void init_done(void);
static inline void led_green_update_1ms(void);
static inline void led_yellow_update_1ms(void);
static inline void led_red_update_1ms(void);
static inline void inputs_poll(void);
bool magnet_isclose(uint16_t value, uint8_t threshold);

///////////////////////////////////////////////////////////////////////////////

volatile Turnout turnout;
volatile Mode mode;
volatile bool btn_flick = false;
#define BTN_FLICK_PERIOD 150 // ms (max uint8_t)
volatile uint8_t prog_btn_counter_ms = 0;
#define PROG_BTN_MAX 20 // ms
volatile uint8_t pseudorand = 0;
volatile uint8_t init_adc_vcc_ok_count = 0;
volatile uint8_t init_adc_vcc_nok_count = 0;
#define INIT_ADC_VCC_LIMIT 5 // cca 250 ms
volatile uint8_t diag_counter = 0;
#define DIAG_UPDATE_PERIOD 200 // 200 ms
FailCode fail_code = fNoFail;

///////////////////////////////////////////////////////////////////////////////

int main() {
	init();

	while (true) {
		inputs_poll();
		set_outputs();
		adc_poll();
		diag_read();

		if (ee_to_save) {
			ee_save();
			ee_to_save = false;
		}
		if (ee_to_store_pos_plus) {
			ee_store_pos_plus();
			ee_to_store_pos_plus = false;
		}
		if (ee_to_store_pos_minus) {
			ee_store_pos_minus();
			ee_to_store_pos_minus = false;
		}

		if (diag_counter >= DIAG_UPDATE_PERIOD) {
			diag_send();
			diag_counter = 0;
		}

		wdt_reset();
		_delay_ms(1);
	}
}

void init(void) {
	ACSR |= ACD;  // analog comparator disable
	TIMSK = 0;
	mode = mInitializing;

	io_init();
	set_output(PIN_LED_RED, true);
	set_output(PIN_LED_YELLOW, true);

	ee_load();
	pwm_servo_init();
	usart_initialize();

	// Timer 2 @ 1 kHz (1 ms)
	TCCR2 = (1 << WGM21) | (1 << CS21) | (1 << CS20); // CTC; prescaler 32×
	OCR2 = 248; // 1 ms
	TIMSK |= (1 << OCIE2);

	// Delay turning-on servo power for pseudorandom time
	uint8_t delay = (turnout.moved_plus % 10)+2; // 100-600 ms; step=50 ms
	for (size_t i = 0; i < delay; i++)
		_delay_ms(50);
	set_output(PIN_LED_GREEN, true);

	set_output(PIN_SERVO_POWER_EN, true);
	pwm_servo_gen(turnout.angle);

	sei(); // enable interrupts globally
	wdt_enable(WDTO_250MS);
}

ISR(BADISR_vect) {
	fail(fBadISR);
}

///////////////////////////////////////////////////////////////////////////////

ISR(TIMER2_COMP_vect) {
	// Timer 2 @ 1 kHz (1 ms)

	static volatile uint8_t counter_20ms = 0;
	counter_20ms++;
	if (counter_20ms >= 20) {
		counter_20ms = 0;
		switch_update();
	}

	static volatile uint16_t counter_50ms = 0;
	counter_50ms++;
	if (counter_50ms >= 50) {
		adc_start_measure();
		counter_50ms = 0;
	}

	static volatile uint8_t flick_counter = 0;
	flick_counter++;
	if (flick_counter >= BTN_FLICK_PERIOD) {
		btn_flick = !btn_flick;
		flick_counter = 0;
	}

	if (prog_btn_counter_ms < 0xFF)
		prog_btn_counter_ms++;

	if (diag_counter < DIAG_UPDATE_PERIOD)
		diag_counter++;

	buttons_update_1ms();
	led_green_update_1ms();
	led_yellow_update_1ms();
	led_red_update_1ms();
	pseudorand++;
}

///////////////////////////////////////////////////////////////////////////////

void on_switch_done(void) {
	if (turnout.position == tpPlus)
		ee_to_store_pos_plus = true;
	else
		ee_to_store_pos_minus = true;
}

void on_btn_pressed(uint8_t button) {
	switch (button) {
	case DEB_BTN:
		if (mode == mRun)
			programming_enter();
		else if (mode == mProgramming)
			programming_leave();
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

	if (mode == mRun) {
		set_output(PIN_OUT_PLUS, my_plus && (get_input(PIN_SLAVE) || in_debounced[DEB_IN_PLUS]));
		set_output(PIN_OUT_MINUS, my_minus && (get_input(PIN_SLAVE) || in_debounced[DEB_IN_MINUS]));
		set_output(PIN_BTN_PLUS_OUT, my_plus || (turnout.position == tpMovingToPlus && btn_flick));
		set_output(PIN_BTN_MINUS_OUT, my_minus || (turnout.position == tpMovingToMinus && btn_flick));
	} else {
		set_output(PIN_OUT_PLUS, false);
		set_output(PIN_OUT_MINUS, false);
		set_output(PIN_BTN_PLUS_OUT, false); // needs to be false to read both buttons
		set_output(PIN_BTN_MINUS_OUT, false); // needs to be false to read both buttons
	}

	// Do not use sensor value to allow relay switching without physical servo
	if (turnout.position == tpPlus)
		set_output(PIN_RELAY_CONTROL, RELAY_STATE_PLUS);
	else if (turnout.position == tpMinus)
		set_output(PIN_RELAY_CONTROL, !RELAY_STATE_PLUS);
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

void init_done(void) {
	pwm_servo_stop();

	set_output(PIN_LED_GREEN, true);
	set_output(PIN_LED_RED, false);
	set_output(PIN_LED_YELLOW, false);
	mode = mRun;
}

void fail(FailCode code) {
	set_output(PIN_LED_GREEN, false);
	set_output(PIN_LED_YELLOW, false);
	set_output(PIN_SERVO_POWER_EN, false);
	fail_code = code;
	mode = mFail;
}

///////////////////////////////////////////////////////////////////////////////

void led_green_update_1ms(void) {
	const uint8_t FLICK_PERIOD = 250;

	if (mode == mProgramming) {
		static uint8_t counter = 0;

		counter++;
		if (counter >= FLICK_PERIOD) {
			set_output(PIN_LED_GREEN, !get_output(PIN_LED_GREEN));
			counter = 0;
		}
	} else {
		set_output(PIN_LED_GREEN, (mode == mRun));
	}
}

void led_yellow_update_1ms(void) {
	const uint8_t FLICK_PERIOD = 250;

	if ((mode == mRun) && (magnet_iswarn())) {
		static uint8_t counter = 0;

		counter++;
		if (counter >= FLICK_PERIOD) {
			set_output(PIN_LED_YELLOW, !get_output(PIN_LED_YELLOW));
			counter = 0;
		}
	} else {
		set_output(PIN_LED_YELLOW, false);
	}
}

void led_red_update_1ms(void) {
	const uint8_t FLICK_PERIOD = 250;

	if (mode == mFail) {
		static uint8_t counter = 0;

		counter++;
		if (counter >= FLICK_PERIOD) {
			set_output(PIN_LED_RED, !get_output(PIN_LED_RED));
			counter = 0;
		}
	} else if (mode == mRun) {
		set_output(PIN_LED_RED, false);
	}
}

///////////////////////////////////////////////////////////////////////////////

void on_adc_done(void) {
	if (mode == mInitializing) {
		if (servo_vcc_value >= SERVO_VCC_MIN) {
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
		if (servo_vcc_value < SERVO_VCC_MIN)
			fail(fServoVCC);
	}
}

///////////////////////////////////////////////////////////////////////////////
