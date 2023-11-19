#include <avr/interrupt.h>
#include <avr/eeprom.h>
#include "diag.h"
#include "common.h"
#include "switch.h"
#include "usart.h"
#include "io.h"
#include "inputs.h"
#include "eeprom.h"

///////////////////////////////////////////////////////////////////////////////

uint16_t servo_vcc_recorded_min = 0xFFFF;
uint16_t servo_vcc_recorded_max = 0;

///////////////////////////////////////////////////////////////////////////////

void diag_send() {
	if (!usart_idle())
		return;

	usart_out[0] = 0xBE;
	usart_out[1] = 0xEF;
	usart_out[2] = DIAG_STREAM_VERSION;
	usart_out[3] = CONFIG_FW_MAJOR;
	usart_out[4] = CONFIG_FW_MINOR;
	usart_out[5] = fail_code;
	usart_out[6] = (magnet_iswarn() << 7) | warnings.all;
	usart_out[7] = ee_fail_count;
	usart_out[8] = ee_last_fail;
	usart_out[9] = mode;
	usart_out[10] = (in_debounced[DEB_IN_PLUS]) | (in_debounced[DEB_IN_MINUS] << 1) | \
		(in_debounced[DEB_BTN_PLUS] << 2) | (in_debounced[DEB_BTN_MINUS] << 3) | \
		(in_debounced[DEB_BTN] << 4) | (in_debounced[DEB_SLAVE] << 5);
	usart_out[11] = get_output(PIN_OUT_PLUS) | (get_output(PIN_OUT_MINUS) << 1) | \
		(get_output(PIN_RELAY_CONTROL) << 2) | (get_output(PIN_SERVO_POWER_EN) << 3);
	usart_out[12] = turnout.position;
	memcpy_v(usart_out+13, &turnout.angle, 2);
	memcpy_v(usart_out+15, &turnout.angle_plus, 2);
	memcpy_v(usart_out+17, &turnout.angle_minus, 2);
	memcpy_v(usart_out+19, &turnout.sensor_plus, 2);
	memcpy_v(usart_out+21, &turnout.sensor_minus, 2);
	memcpy_v(usart_out+23, &turnout.moved_plus, 4);
	memcpy_v(usart_out+27, &turnout.moved_minus, 4);
	usart_out[31] = switch_move_per_tick;
	memcpy_v(usart_out+32, &mag_value, 2);
	memcpy_v(usart_out+34, &servo_vcc_value, 2);
	memcpy_v(usart_out+36, &servo_vcc_recorded_min, 2);
	memcpy_v(usart_out+38, &servo_vcc_recorded_max, 2);

	usart_send(40);
}

void diag_read(void) {
	// Do not use getc to save space
	if (usart_in == 0)
		return;

	char c = usart_in;
	usart_in = 0;

	switch (c) {
	case '+': // move to +
		if ((mode == mOverride) || ((!in_debounced[DEB_IN_PLUS]) && (!in_debounced[DEB_IN_MINUS])))
			switch_turnout(tpPlus);
		break;
	case '-': // move to -
		if ((mode == mOverride) || ((!in_debounced[DEB_IN_PLUS]) && (!in_debounced[DEB_IN_MINUS])))
			switch_turnout(tpMinus);
		break;
	case 'p': // increase speed
		switch_move_per_tick++;
		break;
	case 'm': // decrease speed
		switch_move_per_tick--;
		break;
	case 'r': // reset
		eeprom_update_byte(EEPROM_ADDR_RESET_WANTED, true);
		cli();
		while (true);
		break;
	case 'f': // fail
		fail(fDiag);
		break;
	case 'w': // reset warnings
		warnings.all = 0;
		servo_vcc_recorded_min = 0xFFFF;
		servo_vcc_recorded_max = 0;
		ee_to_save_servo_vcc = true;
		ee_to_save = true;
		ee_reset_fail();
		break;
	case 'o':
		if (mode == mOverride)
			override_leave();
		else if (mode == mRun)
			override_enter();
		break;
	}
}
