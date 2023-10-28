#include <avr/interrupt.h>
#include "diag.h"
#include "common.h"
#include "switch.h"
#include "usart.h"
#include "io.h"
#include "inputs.h"

void diag_send() {
	if (!usart_idle())
		return;

	usart_out[0] = 0xBE;
	usart_out[1] = 0xEF;
	usart_out[2] = DIAG_STREAM_VERSION;
	usart_out[3] = CONFIG_FW_MAJOR;
	usart_out[4] = CONFIG_FW_MINOR;
	usart_out[5] = fail_code;
	usart_out[6] = magnet_iswarn();
	usart_out[7] = mode;
	usart_out[8] = (in_debounced[DEB_IN_PLUS]) | (in_debounced[DEB_IN_MINUS] << 1) | \
		(in_debounced[DEB_BTN_PLUS] << 2) | (in_debounced[DEB_BTN_MINUS] << 3) | \
		(in_debounced[DEB_BTN] << 4) | (in_debounced[DEB_SLAVE] << 5);
	usart_out[9] = get_output(PIN_OUT_PLUS) | (get_output(PIN_OUT_MINUS) << 1) | \
		(get_output(PIN_RELAY_CONTROL) << 2) | (get_output(PIN_SERVO_POWER_EN) << 3);
	usart_out[10] = turnout.position;
	memcpy_v(usart_out+11, &turnout.angle, 2);
	memcpy_v(usart_out+13, &turnout.angle_plus, 2);
	memcpy_v(usart_out+15, &turnout.angle_minus, 2);
	memcpy_v(usart_out+17, &turnout.sensor_plus, 2);
	memcpy_v(usart_out+19, &turnout.sensor_minus, 2);
	memcpy_v(usart_out+21, &turnout.moved_plus, 4);
	memcpy_v(usart_out+25, &turnout.moved_minus, 4);
	usart_out[29] = switch_move_per_tick;
	memcpy_v(usart_out+30, &mag_value, 2);
	memcpy_v(usart_out+32, &servo_vcc_value, 2);

	usart_send(34);
}

void diag_read(void) {
	// Do not use getc to save space
	if (usart_in == 0)
		return;

	char c = usart_in;
	usart_in = 0;

	switch (c) {
	case '+':
		if ((!in_debounced[DEB_IN_PLUS]) && (!in_debounced[DEB_IN_MINUS]))
			switch_turnout(tpPlus);
		break;
	case '-':
		if ((!in_debounced[DEB_IN_PLUS]) && (!in_debounced[DEB_IN_MINUS]))
			switch_turnout(tpMinus);
		break;
	case 'p':
		switch_move_per_tick++;
		break;
	case 'm':
		switch_move_per_tick--;
		break;
	case 'r': // reset
		cli();
		while (true);
		break;
	case 'f': // fail
		fail(fDiag);
		break;
	}
}
