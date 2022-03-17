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

///////////////////////////////////////////////////////////////////////////////

int main();
static inline void init();

///////////////////////////////////////////////////////////////////////////////

int main() {
	init();

	while (true) {
		// problem with PIN_IN_MINUS, PIN_BTN_PLUS_IN, PIN_BTN_MINUS_IN
		//set_output(PIN_OUT_PLUS, !get_input(PIN_BTN_PLUS_IN));
		set_output(PIN_LED_RED, !get_input(PIN_IN_MINUS));
		set_output(PIN_LED_YELLOW, !get_input(PIN_IN_PLUS));
		set_output(PIN_RELAY_CONTROL, !get_input(PIN_BTN_IN));

		_delay_ms(1);
		wdt_reset();
	}
}

static inline void init() {
	ACSR |= ACD;  // analog comparator disable
	io_init();

	// Timer 2 @ 1 kHz (1 ms)
	TCCR2 = (1 << WGM21) | (1 << CS21) | (1 << CS20); // CTC; prescaler 32×
	OCR2 = 248; // 1 ms
	TIMSK = (1 << OCIE2);

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
	set_output(PIN_OUT_PLUS, true);
	_delay_us(10);
	set_output(PIN_OUT_PLUS, false);
}

///////////////////////////////////////////////////////////////////////////////
