#ifndef _INPUTS_H_
#define _INPUTS_H_

/* Inputs debouncing */

#include "io.h"

#define DEBOUNCE_READS 20 // also time in ms

void on_btn_pressed(uint8_t button);
void buttons_update_1ms();

enum DebouncedButton {
	DEB_IN_PLUS = 0,
	DEB_IN_MINUS,
	DEB_BTN_PLUS,
	DEB_BTN_MINUS,
	DEB_BTN,
	DEB_SLAVE,
	DEB_COUNT
};

extern bool in_debounced[DEB_COUNT];

#endif
