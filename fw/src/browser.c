#include <stdlib.h>
#include <string.h>
#include <avr/interrupt.h>
#include "browser.h"
#include "common.h"
#include "switch.h"
#include "usart_printf.h"
#include "io.h"
#include "inputs.h"
#include "pgmown.h"

char* add_trailing_spaces(char* str, uint8_t len) {
	uint8_t length = strlen(str);
	for (uint8_t i = length; i < len; i++)
		str[i] = ' ';
	str[len] = 0;
	return str;
}

static void put_ui8(const char* description, uint8_t value) {
	char buf[4];
	itoa(value, buf, 10);
	add_trailing_spaces(buf, 3);
	fputs(description, stdout);
	puts(buf);
}

static void put_ui16(const char* description, uint16_t value) {
	char buf[6];
	itoa(value, buf, 10);
	add_trailing_spaces(buf, 5);
	fputs(description, stdout);
	puts(buf);
}

static void put_ui32(const char* description, uint32_t value) {
	char buf[11];
	itoa(value, buf, 10);
	add_trailing_spaces(buf, 10);
	fputs(description, stdout);
	puts(buf);
}

void _browser_print(uint8_t part) {
	// Do not use printf to make code smaller
	// part \in 0..19 (do not use more than 10)
	// Real data: sending of browser takes ~80 ms (38400 Baud)

	switch (part) {
	case 0:
		//fputs("\033[2J", stdout); // clrscr
		fputs("\033[21A", stdout); // go n lines above

		puts(PGMSTR("FW=" CONFIG_FW_MAJOR_STR "." CONFIG_FW_MINOR_STR));
		fputs(PGMSTR("Mode="), stdout);
		switch (mode) {
		case mRun:          puts(PGMSTR("mRun         ")); break;
		case mProgramming:  puts(PGMSTR("mProgramming ")); break;
		case mInitializing: puts(PGMSTR("mInitializing")); break;
		case mFail:         puts(PGMSTR("mFail        ")); break;
		}

		puts(PGMSTR("Turnout:"));
		fputs(PGMSTR("  .position="), stdout);
		switch (turnout.position) {
		case tpPlus:          puts(PGMSTR("plus         ")); break;
		case tpMinus:         puts(PGMSTR("minus        ")); break;
		case tpMovingToPlus:  puts(PGMSTR("movingToPlus ")); break;
		case tpMovingToMinus: puts(PGMSTR("movingToMinus")); break;
		}
		break;

	case 1:
		put_ui16(PGMSTR("  .angle="), turnout.angle);
		put_ui16(PGMSTR("  .angle_plus="), turnout.angle_plus);
		put_ui16(PGMSTR("  .angle_minus="), turnout.angle_minus);
		break;

	case 2:
		put_ui16(PGMSTR("  .sensor_plus="), turnout.sensor_plus);
		put_ui16(PGMSTR("  .sensor_minus="), turnout.sensor_minus);
		break;

	case 4:
		put_ui32(PGMSTR("  .moved_plus="), turnout.moved_plus);
		put_ui32(PGMSTR("  .moved_minus="), turnout.moved_minus);
		break;

	case 5:
		put_ui8(PGMSTR("switch_move_per_tick="), switch_move_per_tick);
		put_ui16(PGMSTR("mag_value="), mag_value);
		put_ui16(PGMSTR("servo_vcc_value="), servo_vcc_value);
		break;

	case 6:
		put_ui8(PGMSTR("i_in+="), in_debounced[DEB_IN_PLUS]);
		put_ui8(PGMSTR("i_in-="), in_debounced[DEB_IN_MINUS]);
		put_ui8(PGMSTR("i_btn+="), in_debounced[DEB_BTN_PLUS]);
		put_ui8(PGMSTR("i_btn-="), in_debounced[DEB_BTN_MINUS]);
		put_ui8(PGMSTR("i_btn="), in_debounced[DEB_BTN]);
		put_ui8(PGMSTR("i_slave="), in_debounced[DEB_SLAVE]);
		break;

	case 7:
		fputs(PGMSTR("fail_msg="), stdout);
		puts(fail_msg);
		break;
	}
}

void browser_print(void) {
	// Called each 10ms
	// Prints browser per-parted so buffers are not filled in one large print
	static uint8_t part = 0;
	_browser_print(part);
	part = (part + 1) % 20;
}

void browser_read(void) {
	// Do not use getc to save space
	if (usart_in == 0)
		return;

	char c = usart_in;
	usart_in = 0;

	switch (c) {
	case '+':
		switch_move_per_tick++;
		break;
	case '-':
		switch_move_per_tick--;
		break;
	case 'r': // reset
		cli();
		while (true);
		break;
	}
}
