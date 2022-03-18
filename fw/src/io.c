#include <avr/io.h>
#include "io.h"

void set_output(uint8_t pin, bool state) {
	if (pin >= IO_PINB0 && pin <= IO_PINB7) {
		if (state)
			PORTB |= (1 << (pin-IO_PINB0));
		else
			PORTB &= ~(1 << (pin-IO_PINB0));
	} else if (pin >= IO_PINC0 && pin <= IO_PINC6) {
		if (state)
			PORTC |= (1 << (pin-IO_PINC0));
		else
			PORTC &= ~(1 << (pin-IO_PINC0));
	} else if (pin >= IO_PIND0 && pin <= IO_PIND7) {
		if (state)
			PORTD |= (1 << (pin-IO_PIND0));
		else
			PORTD &= ~(1 << (pin-IO_PIND0));
	}
}

bool get_input(uint8_t pin) {
	if (pin >= IO_PINB0 && pin <= IO_PINB7)
		return (PINB >> (pin-IO_PINB0)) & 1;
	if (pin >= IO_PINC0 && pin <= IO_PINC6)
		return (PINC >> (pin-IO_PINC0)) & 1;
	if (pin >= IO_PIND0 && pin <= IO_PIND7)
		return (PIND >> (pin-IO_PIND0)) & 1;

	return false;
}

void pin_mode(uint8_t pin, uint8_t mode) {
	if (mode == OUTPUT) {
		if (pin >= IO_PINB0 && pin <= IO_PINB7) {
			DDRB |= (1 << (pin-IO_PINB0));
		} else if (pin >= IO_PINC0 && pin <= IO_PINC6) {
			DDRC |= (1 << (pin-IO_PINC0));
		} else if (pin >= IO_PIND0 && pin <= IO_PIND7) {
			DDRD |= (1 << (pin-IO_PIND0));
		}
	} else {
		set_output(pin, mode == INPUT_PULLUP);

		if (pin >= IO_PINB0 && pin <= IO_PINB7) {
			DDRB &= ~(1 << (pin-IO_PINB0));
		} else if (pin >= IO_PINC0 && pin <= IO_PINC6) {
			DDRC &= ~(1 << (pin-IO_PINC0));
		} else if (pin >= IO_PIND0 && pin <= IO_PIND7) {
			DDRD &= ~(1 << (pin-IO_PIND0));
		}
	}
}

void io_init() {
	PORTB = 0; // reset outputs to 0
	PORTC = 0; // reset outputs to 0
	PORTD = 0; // reset outputs to 0

	pin_mode(PIN_IN_PLUS, INPUT);
	pin_mode(PIN_IN_MINUS, INPUT);
	pin_mode(PIN_OUT_PLUS, OUTPUT);
	pin_mode(PIN_OUT_MINUS, OUTPUT);

	pin_mode(PIN_BTN_PLUS_IN, INPUT);
	pin_mode(PIN_BTN_PLUS_OUT, OUTPUT);
	pin_mode(PIN_BTN_MINUS_IN, INPUT);
	pin_mode(PIN_BTN_MINUS_OUT, OUTPUT);

	pin_mode(PIN_SERVO_POWER_EN, OUTPUT);
	pin_mode(PIN_SERVO_PWM, OUTPUT);
	pin_mode(PIN_BTN_IN, INPUT);
	pin_mode(PIN_RELAY_CONTROL, OUTPUT);

	pin_mode(PIN_LED_RED, OUTPUT);
	pin_mode(PIN_LED_YELLOW, OUTPUT);
	pin_mode(PIN_LED_GREEN, OUTPUT);
}
