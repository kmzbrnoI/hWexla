#include <avr/io.h>
#include <avr/interrupt.h>
#include <util/atomic.h>
#include "io.h"

typedef enum {
	adcNone = 0,
	adcMagnet = 1,
	adcServoVcc = 2,
} AdcCurrent;

uint16_t mag_value = 0;
uint16_t servo_vcc_value = 0;
AdcCurrent adcCurrent = adcNone;

///////////////////////////////////////////////////////////////////////////////

static inline void mag_start_measure(void);
static inline void servo_vcc_start_measure(void);

///////////////////////////////////////////////////////////////////////////////

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
	// buttons on active LEDs are considered as inactive
	if (pin == PIN_BTN_PLUS_IN && get_output(PIN_BTN_PLUS_OUT))
		return true;
	if (pin == PIN_BTN_MINUS_IN && get_output(PIN_BTN_MINUS_OUT))
		return true;

	if (pin >= IO_PINB0 && pin <= IO_PINB7)
		return (PINB >> (pin-IO_PINB0)) & 1;
	if (pin >= IO_PINC0 && pin <= IO_PINC6)
		return (PINC >> (pin-IO_PINC0)) & 1;
	if (pin >= IO_PIND0 && pin <= IO_PIND7)
		return (PIND >> (pin-IO_PIND0)) & 1;

	return false;
}

bool get_output(uint8_t pin) {
	if (pin >= IO_PINB0 && pin <= IO_PINB7)
		return (PORTB >> (pin-IO_PINB0)) & 1;
	if (pin >= IO_PINC0 && pin <= IO_PINC6)
		return (PORTC >> (pin-IO_PINC0)) & 1;
	if (pin >= IO_PIND0 && pin <= IO_PIND7)
		return (PORTD >> (pin-IO_PIND0)) & 1;

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

void io_init(void) {
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
	pin_mode(PIN_SLAVE, INPUT);

	pin_mode(PIN_LED_RED, OUTPUT);
	pin_mode(PIN_LED_YELLOW, OUTPUT);
	pin_mode(PIN_LED_GREEN, OUTPUT);

	// ADC init
	ADCSRA = (1 << ADEN) | 0x5; // enable ADC, prescaler 32×
}

void adc_start_measure(void) {
	mag_start_measure();
}

void mag_start_measure(void) {
	adcCurrent = adcMagnet;
	ADMUX = (1 << REFS0) | 0x7; // reference = AVcc (5V), use ADC7
	ADCSRA |= (1 << ADSC); // start
}

void servo_vcc_start_measure(void) {
	adcCurrent = adcServoVcc;
	ADMUX = (1 << REFS0); // reference = AVcc (5V), use ADC0
	ADCSRA |= (1 << ADSC); // start
}

void adc_poll(void) {
	if (ADCSRA & (1 << ADIF)) {
		ADCSRA |= (1 << ADIF); // clear flag

		uint16_t value = ADCL;
		value |= (ADCH << 8);

		AdcCurrent old = adcCurrent;
		adcCurrent = adcNone;
		switch (old) {
		case adcMagnet:
			ATOMIC_BLOCK(ATOMIC_FORCEON) {
				mag_value = value;
			}
			servo_vcc_start_measure();
			break;
		case adcServoVcc:
			ATOMIC_BLOCK(ATOMIC_FORCEON) {
				servo_vcc_value = value;
			}
			on_adc_done();
			break;
		case adcNone:
			break;
		};

	}
}
