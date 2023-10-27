#ifndef _USART_H_
#define _USART_H_

#include <stdbool.h>

#define USART_OUT_BUF_SIZE 64

extern volatile char usart_in; // input is 1-byte bufferred
extern volatile uint8_t usart_out[USART_OUT_BUF_SIZE];

void usart_initialize(void);
uint8_t usart_send(uint8_t len);
bool usart_idle(void);

#endif
