#include <avr/io.h>
#include <avr/sfr_defs.h>
#include <avr/interrupt.h>
//#include <stdio.h>
#include "usart.h"

volatile uint8_t usart_out[USART_OUT_BUF_SIZE];

volatile char usart_in; // input is 1-byte bufferred
volatile bool _sending = false;
volatile uint8_t _send_next_pos;
volatile uint8_t _send_size;

///////////////////////////////////////////////////////////////////////////////

static void _send_next(void);

///////////////////////////////////////////////////////////////////////////////

void usart_initialize(void) {
	usart_in = 0;

	UBRRL = 12; // ~38461.54 baud/s (F_CPU/16/BAUD_RATE-1)
	UBRRH = 0;
	UCSRB = _BV(TXEN) | _BV(RXEN) | _BV(RXCIE) | _BV(TXCIE);
	UCSRC = _BV(URSEL) | _BV(UCSZ1) | _BV(UCSZ0); // async operation, no parity, 1 stop-bit, 8-bit
}

ISR(USART_RXC_vect) {
	uint8_t received;
	if (UCSRA & ((1<<FE)|(1<<DOR)|(1<<PE))) {
		received = UDR; // even bad data must be read
		(void)received;
		return; // return on error
	}
	received = UDR;

	if (usart_in == 0)
		usart_in = received;
}

ISR(USART_TXC_vect) {
	_send_next();
}

uint8_t usart_send(uint8_t len) {
	if (_sending)
		return 1;

	_send_size = len;
	_send_next_pos = 0;
	_send_next();
	return 0;
}

bool usart_idle(void) {
	return !_sending;
}

void _send_next(void) {
	if (_send_next_pos < _send_size) {
		UDR = usart_out[_send_next_pos];
		_send_next_pos++;
	} else {
		_sending = false;
	}
}
