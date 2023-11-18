#include <avr/eeprom.h>
#include "eeprom.h"
#include "common.h"
#include "pwm_servo_gen.h"
#include "switch.h"
#include "diag.h"

/* Often-changed data in EEPROM (position, n.o. turns +/-) are split on multiple
 * bytes to prevent exceeding of EEPROM memory write limit.
 */

#define EEPROM_ADDR_OSCCAL_ID              ((uint8_t*)0x00)
#define EEPROM_ADDR_OSCCAL                 ((uint8_t*)0x01)
#define EEPROM_ADDR_VERSION                ((uint8_t*)0x10)
#define EEPROM_ADDR_FW_VER_MAJOR           ((uint8_t*)0x11)
#define EEPROM_ADDR_FW_VER_MINOR           ((uint8_t*)0x12)
#define EEPROM_ADDR_MODE                   ((uint8_t*)0x13)
#define EEPROM_ADDR_WARNINGS               ((uint8_t*)0x14)
#define EEPROM_ADDR_FAIL_COUNT             ((uint8_t*)0x15)
#define EEPROM_ADDR_LAST_FAIL              ((uint8_t*)0x16)
#define EEPROM_ADDR_POS_PLUS               ((uint16_t*)0x20)
#define EEPROM_ADDR_POS_MINUS              ((uint16_t*)0x22)
#define EEPROM_ADDR_SENS_PLUS              ((uint16_t*)0x24)
#define EEPROM_ADDR_SENS_MINUS             ((uint16_t*)0x26)
#define EEPROM_ADDR_MOVE_PER_TICK          ((uint8_t*)0x28)
#define EEPROM_ADDR_POSITION               ((uint8_t*)0x40) // size: 16 bytes, 8 words
#define EEPROM_ADDR_MOVED_PLUS             ((uint16_t*)0x50) // size: 16 bytes, 8 words
#define EEPROM_ADDR_MOVED_MINUS            ((uint16_t*)0x60) // size: 16 bytes
#define EEPROM_ADDR_SERVO_VCC_MIN          ((uint16_t*)0x70)
#define EEPROM_ADDR_SERVO_VCC_MAX          ((uint16_t*)0x72)

#define OSCCAL_ID_VALID                    0xAA

volatile bool ee_to_save = false;
volatile bool ee_to_save_servo_vcc = false;
volatile bool ee_to_store_pos_plus;
volatile bool ee_to_store_pos_minus;

uint8_t ee_fail_count;
FailCode ee_last_fail;

///////////////////////////////////////////////////////////////////////////////

static void _ee_pos_change(void);

///////////////////////////////////////////////////////////////////////////////


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
		ee_save();
		return;
	}

	warnings.all = eeprom_read_byte(EEPROM_ADDR_WARNINGS);
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

void ee_save(void) {
	eeprom_update_byte(EEPROM_ADDR_VERSION, 1);
	eeprom_update_byte(EEPROM_ADDR_FW_VER_MAJOR, CONFIG_FW_MAJOR);
	eeprom_update_byte(EEPROM_ADDR_FW_VER_MINOR, CONFIG_FW_MINOR);
	eeprom_update_byte(EEPROM_ADDR_MODE, (mode == mOverride));
	eeprom_update_word(EEPROM_ADDR_POS_PLUS, turnout.angle_plus);
	eeprom_update_word(EEPROM_ADDR_POS_MINUS, turnout.angle_minus);
	eeprom_update_word(EEPROM_ADDR_SENS_PLUS, turnout.sensor_plus);
	eeprom_update_word(EEPROM_ADDR_SENS_MINUS, turnout.sensor_minus);
	eeprom_update_byte(EEPROM_ADDR_MOVE_PER_TICK, switch_move_per_tick);
	ee_save_servo_vcc();
	ee_save_warnings();
}

void ee_save_servo_vcc(void) {
	eeprom_update_word(EEPROM_ADDR_SERVO_VCC_MIN, servo_vcc_recorded_min);
	eeprom_update_word(EEPROM_ADDR_SERVO_VCC_MAX, servo_vcc_recorded_max);
}

void ee_save_warnings(void) {
	eeprom_update_byte(EEPROM_ADDR_WARNINGS, warnings.all);
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

void ee_store_pos_plus(void) {
	if (turnout.ee_positions_parity) {
		// = currently is minus
		_ee_pos_change();
	}
}

void ee_store_pos_minus(void) {
	if (!turnout.ee_positions_parity) {
		// = currently is plus
		_ee_pos_change();
	}
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
