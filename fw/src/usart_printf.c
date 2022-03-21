#include <avr/io.h>
#include <avr/sfr_defs.h>
#include <stdio.h>

void usart_initialize(void) {
	UBRRL = 25; // 19200 Baud (F_CPU/16/BAUD_RATE-1)
	UBRRH = 0;
	UCSRB = (1 << TXEN);
	UCSRC = (1 << URSEL) | (1 << UCSZ1) | (1 << UCSZ0); // async operation, no parity, 1 stop-bit, 8-bit
}

void usart_send_byte(char byte, FILE *stream) {
	while (!(UCSRA & (1 << UDRE)));
	UDR = byte;
}

char usart_get_byte(FILE *stream) {
	while (!(UCSRA & (1 << RXC)));
	return UDR;
}
