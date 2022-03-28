#include <avr/io.h>
#include <avr/sfr_defs.h>
#include <avr/interrupt.h>
#include <stdio.h>
#include "usart_printf.h"
#include "ring_queue.h"

FILE uart_output = FDEV_SETUP_STREAM(usart_send_byte, NULL, _FDEV_SETUP_WRITE);
FILE uart_input = FDEV_SETUP_STREAM(NULL, usart_get_byte, _FDEV_SETUP_READ);

volatile RingQueue outq;
volatile RingQueue inq;
volatile bool _sending = false;
volatile bool _outq_overflow = false;

void usart_initialize(void) {
	rq_init(&outq);
	rq_init(&inq);

	UBRRL = 12; // 38400 Baud (F_CPU/16/BAUD_RATE-1)
	UBRRH = 0;
	UCSRB = _BV(TXEN) | _BV(RXEN) | _BV(RXCIE) | _BV(TXCIE);
	UCSRC = _BV(URSEL) | _BV(UCSZ1) | _BV(UCSZ0); // async operation, no parity, 1 stop-bit, 8-bit
}

void usart_send_byte(char byte, FILE *stream) {
	if (rq_full(&outq)) {
		_outq_overflow = true;
		return;
	}
	rq_enqueue(&outq, byte);
}

void usart_q_poll() {
	if ((!_sending) && (_outq_overflow)) {
		// Print overflow only after all data sent
		// Maybe this should be done better (send 'OVERFLOW' as soon as there is space)
		_outq_overflow = false;
		printf("-- OVERFLOW --\n");
	}

	if ((!rq_empty(&outq)) && (!_sending)) {
		_sending = true;
		while (!(UCSRA & (1 << UDRE)));
		UDR = rq_dequeue(&outq);
	}
}

char usart_get_byte(FILE *stream) {
	if (rq_empty(&inq))
		return 0;
	return rq_dequeue(&inq);
}

ISR(USART_RXC_vect) {
	uint8_t received;
	if (UCSRA & ((1<<FE)|(1<<DOR)|(1<<PE))) {
		received = UDR; // even bad data must be read
		(void)received;
		return; // return on error
	}
	received = UDR;

	if (!rq_full(&inq))
		rq_enqueue(&inq, UDR);
}

ISR(USART_TXC_vect) {
	if (!rq_empty(&outq)) {
		UDR = rq_dequeue(&outq);
	} else {
		_sending = false;
	}
}

bool is_stdin_data() {
	return !rq_empty(&inq);
}
