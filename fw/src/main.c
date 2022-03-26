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
void set_outputs();
void programming_enter();
void programming_leave();
void led_yellow_update_1ms();

///////////////////////////////////////////////////////////////////////////////

volatile Turnout turnout;
volatile Mode mode;
volatile bool btn_flick = false;
#define BTN_FLICK_PERIOD 250 // ms (max uint8_t)

///////////////////////////////////////////////////////////////////////////////

int main() {
	init();

	while (true) {
		set_outputs();
		mag_poll();

		if (ee_to_save) {
			ee_save();
			ee_to_save = false;
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
	ee_load();
	pwm_servo_init();
	usart_initialize();

	// Timer 2 @ 1 kHz (1 ms)
	TCCR2 = (1 << WGM21) | (1 << CS21) | (1 << CS20); // CTC; prescaler 32×
	OCR2 = 248; // 1 ms
	TIMSK |= (1 << OCIE2);

	set_output(PIN_LED_RED, true);
	set_output(PIN_LED_YELLOW, true);
	set_output(PIN_LED_GREEN, true);
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
		mag_start_measure();
		counter_50ms = 0;
	}

	static volatile uint8_t flick_counter = 0;
	flick_counter++;
	if (flick_counter >= BTN_FLICK_PERIOD) {
		btn_flick = !btn_flick;
		flick_counter = 0;
	}

	buttons_update_1ms();
	led_yellow_update_1ms();
}

///////////////////////////////////////////////////////////////////////////////

void on_switch_done() {
}

void on_btn_pressed(uint8_t button) {
	switch (button) {
	case DEB_IN_PLUS:
		switch_turnout(tpPlus);
		break;
	case DEB_IN_MINUS:
		switch_turnout(tpMinus);
		break;
	case DEB_BTN_PLUS:
		break;
	case DEB_BTN_MINUS:
		break;
	case DEB_BTN:
		if (mode == mRun)
			programming_enter();
		else if (mode == mProgramming)
			programming_leave();
		break;
	}
}

///////////////////////////////////////////////////////////////////////////////

void set_outputs() {
	if (mode == mRun) {
		set_output(PIN_OUT_PLUS, (turnout.position == tpPlus) &&
		           (get_input(PIN_SLAVE) || !in_debounced[DEB_IN_PLUS]));
		set_output(PIN_OUT_MINUS, (turnout.position == tpMinus) &&
		           (get_input(PIN_SLAVE) || !in_debounced[DEB_IN_MINUS]));
	} else {
		set_output(PIN_OUT_PLUS, false);
		set_output(PIN_OUT_MINUS, false);
	}

	set_output(PIN_BTN_PLUS_OUT, turnout.position == tpPlus || (turnout.position == tpMovingToPlus && btn_flick));
	set_output(PIN_BTN_MINUS_OUT, turnout.position == tpMinus || (turnout.position == tpMovingToMinus && btn_flick));
}

///////////////////////////////////////////////////////////////////////////////

void programming_enter() {
	if ((turnout.position != tpPlus) && (turnout.position != tpMinus))
		return; // allow programming entry only when not moving

	mode = mProgramming;
}

void programming_leave() {
	if (!mag_available)
		return;

	mode = mRun;

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
		static counter = 0;

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
