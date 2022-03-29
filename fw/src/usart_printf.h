#ifndef USART_PRINTF_H
#define USART_PRINTF_H

#include <stdio.h>
#include <stdbool.h>
#include "ring_queue.h"

void usart_initialize(void);
void usart_send_byte(char byte, FILE *stream);
void usart_q_poll();

extern FILE uart_output;

extern volatile RingQueue usart_outq;
extern volatile char usart_in; // input is 1-byte bufferred

#endif
