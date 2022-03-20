/* Main source file of Servocontroller ATmega CPU.
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

///////////////////////////////////////////////////////////////////////////////

int main();
static inline void init();

///////////////////////////////////////////////////////////////////////////////

volatile Turnout turnout;

///////////////////////////////////////////////////////////////////////////////

int main() {
	init();

	while (true) {
		_delay_ms(1);
		wdt_reset();
	}
}

static inline void init() {
	ACSR |= ACD;  // analog comparator disable
	TIMSK = 0;

	io_init();
	pwm_servo_init();

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

	buttons_update_1ms();
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
		break;
	}
}

///////////////////////////////////////////////////////////////////////////////
