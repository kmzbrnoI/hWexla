#include <avr/interrupt.h>
#include "pwm_servo_gen.h"
#include "io.h"

volatile int16_t _angle;
volatile int16_t _angle_buf;
volatile bool _should_generate = false;

static inline void _pwm_servo_start(uint16_t angle) {
	OCR1A = angle+9000;
	TCCR1B |= (1 << CS11); // Clock source = prescaler 8×
}

static inline void _pwm_servo_stop(void) {
	TCCR1B &= 0xF8; // CS10=0,CS11=0,CS12=0
}

static inline bool _pwm_output_pin_state(void) {
	return (PINB & (1 << PB1)) > 0;
}

void pwm_servo_init(void) {
	// Setup 16-bit timer 1 for hardware PWM generation
	TCCR1A = (1 << COM1A1) | (1 << COM1A0); // OC1A on Compare Match high level
	TCCR1B = (1 << WGM13); // Phase&freq correct PWM TOP=ICR1
	TIMSK |= (1 << OCIE1A) | (1 << OCIE1B);
	ICR1 = 10000;
	OCR1B = 0;
}

void pwm_servo_gen(int16_t angle) {
	_angle = angle;

	if (!pwm_servo_generating()) {
		// start PWM generation
		TCNT1 = 0;
		_should_generate = true;
		_pwm_servo_start(angle);
	}
}

void pwm_servo_stop(void) {
	_should_generate = false;
	if (!_pwm_output_pin_state())
		_pwm_servo_stop();
}

bool pwm_servo_generating(void) {
	return (TCCR1B & 0x07) > 0; // if any clock source is selected
}

ISR(TIMER1_COMPA_vect) {
	if (!_pwm_output_pin_state()) {
		// On trailing edge → possibly stop PWM
		if (!_should_generate)
			_pwm_servo_stop();
	}
}

ISR(TIMER1_COMPB_vect) {
	// Interrupt after full period → update pwm width
	OCR1A = _angle+9000;
}
