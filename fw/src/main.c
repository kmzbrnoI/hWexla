/* Main source file of Servocontroller ATmega CPU.
 */

#include <stdint.h>
#include <stdbool.h>
#include <util/delay.h>
#include <avr/interrupt.h>
#include <avr/io.h>
#include <avr/wdt.h>
#include <avr/eeprom.h>

///////////////////////////////////////////////////////////////////////////////

int main();
static inline void init();

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
	wdt_enable(WDTO_250MS);

	sei(); // enable interrupts globally
}

///////////////////////////////////////////////////////////////////////////////

ISR(TIMER0_COMPA_vect) {
}

///////////////////////////////////////////////////////////////////////////////
