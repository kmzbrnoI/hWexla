#ifndef _INPUTS_H_
#define _INPUTS_H_

/* Inputs debouncing */

#include "io.h"

#define DEBOUNCE_READS 20 // also time in ms

void inputs_init(void);
void on_btn_pressed(uint8_t input);
void inputs_update_1ms(void);
void inputs_update(void);

enum DebouncedInput {
	DEB_IN_PLUS = 0,
	DEB_IN_MINUS,
	DEB_BTN_PLUS,
	DEB_BTN_MINUS,
	DEB_BTN,
	DEB_SLAVE,
	DEB_COUNT
};

extern volatile bool in_debounced[DEB_COUNT];

#endif
