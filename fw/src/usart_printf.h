#ifndef USART_PRINTF_H
#define USART_PRINTF_H

#include <stdio.h>
#include <stdbool.h>

void usart_initialize(void);
void usart_send_byte(char byte, FILE *stream);
char usart_get_byte(FILE *stream);
bool is_stdin_data();
void usart_q_poll();

extern FILE uart_output;
extern FILE uart_input;

#endif
