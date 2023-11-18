#include <avr/io.h>
#include <stddef.h>
#include "inputs.h"
#include "io.h"

bool in_debounced[DEB_COUNT];
uint8_t _counters[DEB_COUNT];
uint8_t _inputs[DEB_COUNT] = {
	PIN_IN_PLUS,
	PIN_IN_MINUS,
	PIN_BTN_PLUS_IN,
	PIN_BTN_MINUS_IN,
	PIN_BTN_IN,
	PIN_SLAVE,
};

void _inputs_update_1ms(uint8_t i) {
	if (!get_input(_inputs[i])) {
		if (_counters[i] < DEBOUNCE_READS) {
			_counters[i]++;
			if (_counters[i] == DEBOUNCE_READS && !in_debounced[i]) {
				in_debounced[i] = true;
				on_btn_pressed(i);
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

void inputs_update_1ms(void) {
	for (size_t i = 0; i < DEB_COUNT; i++)
		_inputs_update_1ms(i);
}
