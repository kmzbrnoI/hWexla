#include <stdlib.h>
#include <string.h>
#include "browser.h"
#include "common.h"
#include "switch.h"
#include "usart_printf.h"
#include "io.h"

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
		fputs("\033[13A", stdout); // go n lines above

		fputs("Mode=", stdout);
		switch (mode) {
		case mRun:          puts("mRun         "); break;
		case mProgramming:  puts("mProgramming "); break;
		case mInitializing: puts("mInitializing"); break;
		case mFail:         puts("mFail        "); break;
		}

		puts("Turnout:");
		fputs("  .position=", stdout);
		switch (turnout.position) {
		case tpPlus:          puts("plus         "); break;
		case tpMinus:         puts("minus        "); break;
		case tpMovingToPlus:  puts("movingToPlus "); break;
		case tpMovingToMinus: puts("movingToMinus"); break;
		}
		break;

	case 1:
		put_ui16("  .angle=", turnout.angle);
		put_ui16("  .angle_plus=", turnout.angle_plus);
		put_ui16("  .angle_minus=", turnout.angle_minus);
		put_ui16("  .sensor_plus=", turnout.sensor_plus);
		put_ui16("  .sensor_minus=", turnout.sensor_minus);
		break;

	case 4:
		put_ui32("  .moved_plus=", turnout.moved_plus);
		put_ui32("  .moved_minus=", turnout.moved_minus);
		break;

	case 5:
		put_ui8("switch_move_per_tick=", switch_move_per_tick);
		put_ui16("mag_value=", mag_value);
		put_ui16("servo_vcc_value=", servo_vcc_value);
		break;
	}
}

void browser_print() {
	// Called each 10ms
	// Prints browser per-parted so buffers are not filled in one large print
	static uint8_t part = 0;
	_browser_print(part);
	part = (part + 1) % 20;
}

void browser_read() {
	if (!is_stdin_data())
		return;
	char c = getc(stdin);
	
	switch (c) {
	case '+':
		switch_move_per_tick++;
		break;
	case '-':
		switch_move_per_tick--;
		break;
	}
}
