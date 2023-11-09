#ifndef _IO_H_
#define _IO_H_

/* General digital IO functions, simillar to Arduino. */

#include <stdbool.h>
#include <stdint.h>

#define OUTPUT 0
#define INPUT 1
#define INPUT_PULLUP 2

#define IO_PINB0 0
#define IO_PINB1 1
#define IO_PINB2 2
#define IO_PINB3 3
#define IO_PINB4 4
#define IO_PINB5 5
#define IO_PINB6 6
#define IO_PINB7 7

#define IO_PINC0 8
#define IO_PINC1 9
#define IO_PINC2 10
#define IO_PINC3 11
#define IO_PINC4 12
#define IO_PINC5 13
#define IO_PINC6 14

#define IO_PIND0 16
#define IO_PIND1 17
#define IO_PIND2 18
#define IO_PIND3 19
#define IO_PIND4 20
#define IO_PIND5 21
#define IO_PIND6 22
#define IO_PIND7 23


#define PIN_IN_PLUS IO_PINC3
#define PIN_IN_MINUS IO_PINC2
#define PIN_OUT_PLUS IO_PINB2
#define PIN_OUT_MINUS IO_PIND2

#define PIN_BTN_PLUS_IN IO_PINC5
#define PIN_BTN_PLUS_OUT IO_PIND3
#define PIN_BTN_MINUS_IN IO_PINC4
#define PIN_BTN_MINUS_OUT IO_PINB6

#define PIN_SERVO_POWER_EN IO_PINB0
#define PIN_SERVO_PWM IO_PINB1
#define PIN_SERVO_VCC_IN IO_PINC0
#define PIN_BTN_IN IO_PINC1
#define PIN_RELAY_CONTROL IO_PIND4
#define PIN_SLAVE IO_PINB7

#define PIN_LED_RED IO_PIND7
#define PIN_LED_YELLOW IO_PIND6
#define PIN_LED_GREEN IO_PIND5

#define MAG_MAX_VALUE 1023
#define SERVO_VCC_WARN  983 // 4.8 V (= 983/1024 * 5.0)
#define SERVO_VCC_MIN  921 // 4.5 V (= 921/1024 * 5.0)

void set_output(uint8_t pin, bool state);
bool get_input(uint8_t pin);
bool get_output(uint8_t pin);
void pin_mode(uint8_t pin, uint8_t mode);
void io_init(void);
void io_fail(void);

void adc_start_measure(void);
void adc_poll(void);
void on_adc_done(void);
extern volatile uint16_t mag_value;
extern volatile uint16_t servo_vcc_value;

#endif
