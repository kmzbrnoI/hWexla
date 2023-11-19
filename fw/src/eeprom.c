#include <avr/eeprom.h>
#include "eeprom.h"
#include "common.h"
#include "pwm_servo_gen.h"
#include "switch.h"
#include "diag.h"

volatile bool ee_to_save = false;
volatile bool ee_to_save_servo_vcc = false;
volatile bool ee_to_save_pos_plus;
volatile bool ee_to_save_pos_minus;

uint8_t ee_fail_count;
FailCode ee_last_fail;

///////////////////////////////////////////////////////////////////////////////

static bool _ee_nonblock_update_byte(uint8_t* addr, uint8_t value);
static bool _ee_nonblock_update_word(uint16_t* addr, uint16_t value);
static void _ee_pos_change(void);

///////////////////////////////////////////////////////////////////////////////

bool _ee_nonblock_update_byte(uint8_t* addr, uint8_t value) {
	if (!eeprom_is_ready()) return false;
	eeprom_update_byte(addr, value);
	return true;
}

bool _ee_nonblock_update_word(uint16_t* addr, uint16_t value) {
	if (!eeprom_is_ready()) return false;
	eeprom_update_byte((uint8_t*)addr, value & 0xFF);
	if (!eeprom_is_ready()) return false;
	eeprom_update_byte((uint8_t*)addr+1, value >> 8);
	return true;
}

void _ee_default_config(void) {
	turnout.angle_plus = 350;
	turnout.angle_minus = 150;
	turnout.angle = 250;
	turnout.sensor_plus = 750;
	turnout.sensor_minus = 250;
	turnout.moved_plus = 0;
	turnout.moved_minus = 0;

	for (size_t i = 0; i < EEPROM_MOVED_COUNT; i++) {
		eeprom_write_word(EEPROM_ADDR_MOVED_PLUS + i, 0);
		eeprom_write_word(EEPROM_ADDR_MOVED_MINUS + i, 0);
	}
	for (size_t i = 0; i < EEPROM_POSITION_COUNT; i++)
		eeprom_write_byte(EEPROM_ADDR_POSITION + i, 0);

	ee_reset_fail();
}

void ee_load(void) {
	if (eeprom_read_byte(EEPROM_ADDR_OSCCAL_ID) != OSCCAL_ID_VALID) {
		fail(fOscCalMissing); // will not exit fuction
	} else {
		OSCCAL = eeprom_read_byte(EEPROM_ADDR_OSCCAL);
	}

	uint8_t version = eeprom_read_byte(EEPROM_ADDR_VERSION);
	if (version == 0xFF) {
		_ee_default_config();
		while (!ee_save());
		return;
	}

	warnings.all = eeprom_read_byte(EEPROM_ADDR_WARNINGS) & 0x7F;
	ee_fail_count = eeprom_read_byte(EEPROM_ADDR_FAIL_COUNT);
	ee_last_fail = eeprom_read_byte(EEPROM_ADDR_LAST_FAIL);

	turnout.angle_plus = eeprom_read_word(EEPROM_ADDR_POS_PLUS);
	if (turnout.angle_plus > PWM_ANGLE_MAX)
		turnout.angle_plus = PWM_ANGLE_MAX;
	turnout.angle_minus = eeprom_read_word(EEPROM_ADDR_POS_MINUS);
	if (turnout.angle_minus > PWM_ANGLE_MAX)
		turnout.angle_minus = PWM_ANGLE_MAX;

	turnout.sensor_plus = eeprom_read_word(EEPROM_ADDR_SENS_PLUS);
	turnout.sensor_minus = eeprom_read_word(EEPROM_ADDR_SENS_MINUS);
	switch_move_per_tick = eeprom_read_byte(EEPROM_ADDR_MOVE_PER_TICK);

	turnout.moved_plus = 0;
	turnout.moved_minus = 0;
	turnout.ee_moved_plus_mini = 0;
	turnout.ee_moved_minus_mini = 0;
	for (size_t i = 0; i < EEPROM_MOVED_COUNT; i++) {
		turnout.ee_moved_plus[i] = eeprom_read_word(EEPROM_ADDR_MOVED_PLUS + i);
		turnout.moved_plus += turnout.ee_moved_plus[i];
		if (turnout.ee_moved_plus[i] < turnout.ee_moved_plus[turnout.ee_moved_plus_mini])
			turnout.ee_moved_plus_mini = i;

		turnout.ee_moved_minus[i] = eeprom_read_word(EEPROM_ADDR_MOVED_MINUS + i);
		turnout.moved_minus += turnout.ee_moved_minus[i];
		if (turnout.ee_moved_minus[i] < turnout.ee_moved_minus[turnout.ee_moved_minus_mini])
			turnout.ee_moved_minus_mini = i;
	}

	turnout.ee_positions_parity = false; // false = tpPlus
	for (size_t i = 0; i < EEPROM_POSITION_COUNT; i++) {
		turnout.ee_positions[i] = eeprom_read_byte(EEPROM_ADDR_POSITION + i);
		turnout.ee_positions_parity ^= (turnout.ee_positions[i] > 0);
	}

	turnout.position = turnout.ee_positions_parity ? tpMinus : tpPlus;
	turnout.angle = (turnout.position == tpPlus) ? turnout.angle_plus : turnout.angle_minus;

	servo_vcc_recorded_min = eeprom_read_word(EEPROM_ADDR_SERVO_VCC_MIN);
	servo_vcc_recorded_max = eeprom_read_word(EEPROM_ADDR_SERVO_VCC_MAX);
}

bool ee_save(void) {
	if (!_ee_nonblock_update_byte(EEPROM_ADDR_VERSION, 1)) return false;
	if (!_ee_nonblock_update_byte(EEPROM_ADDR_FW_VER_MAJOR, CONFIG_FW_MAJOR)) return false;
	if (!_ee_nonblock_update_byte(EEPROM_ADDR_FW_VER_MINOR, CONFIG_FW_MINOR)) return false;
	if (!_ee_nonblock_update_byte(EEPROM_ADDR_MODE, (mode == mOverride))) return false;
	if (!_ee_nonblock_update_word(EEPROM_ADDR_POS_PLUS, turnout.angle_plus)) return false;
	if (!_ee_nonblock_update_word(EEPROM_ADDR_POS_MINUS, turnout.angle_minus)) return false;
	if (!_ee_nonblock_update_word(EEPROM_ADDR_SENS_PLUS, turnout.sensor_plus)) return false;
	if (!_ee_nonblock_update_word(EEPROM_ADDR_SENS_MINUS, turnout.sensor_minus)) return false;
	if (!_ee_nonblock_update_byte(EEPROM_ADDR_MOVE_PER_TICK, switch_move_per_tick)) return false;
	if (!_ee_nonblock_update_byte(EEPROM_ADDR_WARNINGS, warnings.all & 0x7F)) return false;
	if (!ee_save_servo_vcc()) return false;

	return true;
}

bool ee_save_servo_vcc(void) {
	if (!_ee_nonblock_update_word(EEPROM_ADDR_SERVO_VCC_MIN, servo_vcc_recorded_min)) return false;
	if (!_ee_nonblock_update_word(EEPROM_ADDR_SERVO_VCC_MAX, servo_vcc_recorded_max)) return false;
	return true;
}

void ee_incr_moved_plus(void) {
	turnout.moved_plus++;
	turnout.ee_moved_plus[turnout.ee_moved_plus_mini]++;
	eeprom_write_word(EEPROM_ADDR_MOVED_PLUS + turnout.ee_moved_plus_mini,
	                  turnout.ee_moved_plus[turnout.ee_moved_plus_mini]);
	turnout.ee_moved_plus_mini = (turnout.ee_moved_plus_mini+1) % EEPROM_MOVED_COUNT;
}

void ee_incr_moved_minus(void) {
	turnout.moved_minus++;
	turnout.ee_moved_minus[turnout.ee_moved_minus_mini]++;
	eeprom_write_word(EEPROM_ADDR_MOVED_MINUS + turnout.ee_moved_minus_mini,
	                  turnout.ee_moved_minus[turnout.ee_moved_minus_mini]);
	turnout.ee_moved_minus_mini = (turnout.ee_moved_minus_mini+1) % EEPROM_MOVED_COUNT;
}

bool ee_save_pos_plus(void) {
	if (turnout.ee_positions_parity) {
		// = currently is minus
		if (!eeprom_is_ready()) return false;
		_ee_pos_change();
	}
	return true;
}

bool ee_save_pos_minus(void) {
	if (!turnout.ee_positions_parity) {
		// = currently is plus
		if (!eeprom_is_ready()) return false;
		_ee_pos_change();
	}
	return true;
}

void _ee_pos_change(void) {
	uint8_t i = pseudorand % EEPROM_POSITION_COUNT;
	turnout.ee_positions_parity = !turnout.ee_positions_parity;
	turnout.ee_positions[i] = !turnout.ee_positions[i];
	eeprom_write_byte(EEPROM_ADDR_POSITION + i, turnout.ee_positions[i]);
}

uint8_t ee_mode(void) {
	return eeprom_read_byte(EEPROM_ADDR_MODE);
}

void ee_fail(FailCode code) {
	ee_last_fail = code;
	if (ee_fail_count < 0xFF)
		ee_fail_count++;
	eeprom_update_byte(EEPROM_ADDR_FAIL_COUNT, ee_fail_count);
	eeprom_update_byte(EEPROM_ADDR_LAST_FAIL, ee_last_fail);
}

void ee_reset_fail(void) {
	ee_fail_count = 0;
	ee_last_fail = fNoFail;
	eeprom_update_byte(EEPROM_ADDR_FAIL_COUNT, ee_fail_count);
	eeprom_update_byte(EEPROM_ADDR_LAST_FAIL, ee_last_fail);
}
