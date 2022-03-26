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

#include "io.h"
#include "pwm_servo_gen.h"
#include "switch.h"
#include "inputs.h"
#include "eeprom.h"
#include "usart_printf.h"

///////////////////////////////////////////////////////////////////////////////

int main();
static inline void init();
static inline void set_outputs();
static inline void programming_enter();
static inline void programming_leave();
static inline void led_yellow_update_1ms();
static inline void inputs_poll();

///////////////////////////////////////////////////////////////////////////////

volatile Turnout turnout;
volatile Mode mode;
volatile bool btn_flick = false;
#define BTN_FLICK_PERIOD 150 // ms (max uint8_t)
volatile uint8_t prog_btn_counter_ms = 0;
#define PROG_BTN_MAX 20 // ms
volatile uint8_t pseudorand = 0;

///////////////////////////////////////////////////////////////////////////////

int main() {
	init();

	while (true) {
		inputs_poll();
		set_outputs();
		adc_poll();

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

		wdt_reset();
		_delay_ms(1);
	}
}

static inline void init() {
	ACSR |= ACD;  // analog comparator disable
	TIMSK = 0;
	stdout = &uart_output;
	mode = mRun;

	io_init();
	set_output(PIN_LED_RED, true);
	set_output(PIN_LED_YELLOW, true);
	set_output(PIN_LED_GREEN, true);

	ee_load();
	pwm_servo_init();
	usart_initialize();

	// Timer 2 @ 1 kHz (1 ms)
	TCCR2 = (1 << WGM21) | (1 << CS21) | (1 << CS20); // CTC; prescaler 32×
	OCR2 = 248; // 1 ms
	TIMSK |= (1 << OCIE2);

	_delay_ms(250);
	set_output(PIN_LED_RED, false);
	set_output(PIN_LED_YELLOW, false);

	set_output(PIN_LED_GREEN, true);
	set_output(PIN_SERVO_POWER_EN, true);

	sei(); // enable interrupts globally
	wdt_enable(WDTO_250MS);
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

	buttons_update_1ms();
	led_yellow_update_1ms();
	pseudorand++;
}

///////////////////////////////////////////////////////////////////////////////

void on_switch_done() {
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

void inputs_poll() {
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

void set_outputs() {
	if (mode == mRun) {
		set_output(PIN_OUT_PLUS, (turnout.position == tpPlus) &&
		           (get_input(PIN_SLAVE) || in_debounced[DEB_IN_PLUS]));
		set_output(PIN_OUT_MINUS, (turnout.position == tpMinus) &&
		           (get_input(PIN_SLAVE) || in_debounced[DEB_IN_MINUS]));
		set_output(PIN_BTN_PLUS_OUT, turnout.position == tpPlus || (turnout.position == tpMovingToPlus && btn_flick));
		set_output(PIN_BTN_MINUS_OUT, turnout.position == tpMinus || (turnout.position == tpMovingToMinus && btn_flick));
	} else {
		set_output(PIN_OUT_PLUS, false);
		set_output(PIN_OUT_MINUS, false);
		set_output(PIN_BTN_PLUS_OUT, false); // needs to be false to read both buttons
		set_output(PIN_BTN_MINUS_OUT, false); // needs to be false to read both buttons
	}


}

///////////////////////////////////////////////////////////////////////////////

void programming_enter() {
	if ((turnout.position != tpPlus) && (turnout.position != tpMinus))
		return; // allow programming entry only when not moving

	mode = mProgramming;
	pwm_servo_gen(turnout.angle);
}

void programming_leave() {
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

///////////////////////////////////////////////////////////////////////////////

void led_yellow_update_1ms() {
	const uint8_t FLICK_PERIOD = 250;

	if (mode == mProgramming) {
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

///////////////////////////////////////////////////////////////////////////////
