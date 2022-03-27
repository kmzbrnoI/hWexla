#include <avr/io.h>
#include <avr/sfr_defs.h>
#include <avr/interrupt.h>
#include <stdio.h>
#include "usart_printf.h"
#include "simple_queue.h"

FILE uart_output = FDEV_SETUP_STREAM(usart_send_byte, NULL, _FDEV_SETUP_WRITE);
FILE uart_input = FDEV_SETUP_STREAM(NULL, usart_get_byte, _FDEV_SETUP_READ);

volatile SimpleQueue outq;
volatile SimpleQueue inq;
volatile bool _sending = false;
volatile bool _outq_overflow = false;

void usart_initialize(void) {
	sq_init(&outq);
	sq_init(&inq);

	UBRRL = 25; // 19200 Baud (F_CPU/16/BAUD_RATE-1)
	UBRRH = 0;
	UCSRB = _BV(TXEN) | _BV(RXEN) | _BV(RXCIE) | _BV(TXCIE);
	UCSRC = _BV(URSEL) | _BV(UCSZ1) | _BV(UCSZ0); // async operation, no parity, 1 stop-bit, 8-bit
}

void usart_send_byte(char byte, FILE *stream) {
	if (sq_full(&outq)) {
		_outq_overflow = true;
		return;
	}
	sq_enqueue(&outq, byte);
}

void usart_q_poll() {
	if ((!_sending) && (_outq_overflow)) {
		// Print overflow only after all data sent
		// Maybe this should be done better (send 'OVERFLOW' as soon as there is space)
		_outq_overflow = false;
		printf("-- OVERFLOW --\n");
	}

	if ((!sq_empty(&outq)) && (!_sending)) {
		_sending = true;
		while (!(UCSRA & (1 << UDRE)));
		UDR = sq_dequeue(&outq);
	}
}

char usart_get_byte(FILE *stream) {
	if (sq_empty(&inq))
		return 0;
	return sq_dequeue(&inq);
}

ISR(USART_RXC_vect) {
	if (UCSRA & ((1<<FE)|(1<<DOR)|(1<<PE)))
		return; // return on error

	if (!sq_full(&inq))
		sq_enqueue(&inq, UDR);
}

ISR(USART_TXC_vect) {
	if (!sq_empty(&outq)) {
		UDR = sq_dequeue(&outq);
	} else {
		_sending = false;
	}
}

bool is_stdin_data() {
	return !sq_empty(&inq);
}
