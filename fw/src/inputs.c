#include <avr/io.h>
#include <stddef.h>
#include <string.h>
#include "inputs.h"
#include "io.h"

volatile bool in_debounced[DEB_COUNT];
volatile uint8_t _counters[DEB_COUNT];
volatile bool _pressed_pending[DEB_COUNT];
uint8_t _inputs[DEB_COUNT] = {
	PIN_IN_PLUS,
	PIN_IN_MINUS,
	PIN_BTN_PLUS_IN,
	PIN_BTN_MINUS_IN,
	PIN_BTN_IN,
	PIN_SLAVE,
};

///////////////////////////////////////////////////////////////////////////////

void inputs_init(void) {
	memset((uint8_t*)_pressed_pending, 0, DEB_COUNT);
}

void inputs_update_1ms(void) {
	for (size_t i = 0; i < DEB_COUNT; i++) {
		if (!get_input(_inputs[i])) {
			if (_counters[i] < DEBOUNCE_READS) {
				_counters[i]++;
				if (_counters[i] == DEBOUNCE_READS && !in_debounced[i]) {
					in_debounced[i] = true;
					_pressed_pending[i] = true;
				}
			}
		} else {
			if (_counters[i] > 0) {
				_counters[i]--;
				if (_counters[i] == 0 && in_debounced[i])
					in_debounced[i] = false;
			}
		}
	}
}

void inputs_update(void) {
	for (size_t i = 0; i < DEB_COUNT; i++) {
		if (_pressed_pending[i]) {
			on_btn_pressed(i);
			_pressed_pending[i] = false;
		}
	}
}
