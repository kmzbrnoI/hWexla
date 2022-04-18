#include <avr/eeprom.h>
#include "eeprom.h"
#include "common.h"
#include "pwm_servo_gen.h"
#include "switch.h"

/* Often-changed data in EEPROM (position, n.o. turns +/-) are split on multiple
 * bytes to prevent exceeding of EEPROM memory write limit.
 */

#define EEPROM_ADDR_VERSION                ((uint8_t*)0x00)
#define EEPROM_ADDR_FW_VER_MAJOR           ((uint8_t*)0x01)
#define EEPROM_ADDR_FW_VER_MINOR           ((uint8_t*)0x02)
#define EEPROM_ADDR_POS_PLUS               ((uint16_t*)0x10)
#define EEPROM_ADDR_POS_MINUS              ((uint16_t*)0x12)
#define EEPROM_ADDR_SENS_PLUS              ((uint16_t*)0x14)
#define EEPROM_ADDR_SENS_MINUS             ((uint16_t*)0x16)
#define EEPROM_ADDR_MOVE_PER_TICK          ((uint8_t*)0x18)
#define EEPROM_ADDR_POSITION               ((uint8_t*)0x30) // size: 16 bytes, 8 words
#define EEPROM_ADDR_MOVED_PLUS             ((uint16_t*)0x40) // size: 16 bytes, 8 words
#define EEPROM_ADDR_MOVED_MINUS            ((uint16_t*)0x50) // size: 16 bytes

volatile bool ee_to_save = false;
volatile bool ee_to_store_pos_plus;
volatile bool ee_to_store_pos_minus;

void _ee_pos_change();

///////////////////////////////////////////////////////////////////////////////


void _ee_default_config() {
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
}

void ee_load() {
	uint8_t version = eeprom_read_byte(EEPROM_ADDR_VERSION);
	if (version == 0xFF) {
		_ee_default_config();
		ee_save();
		return;
	}

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
}

void ee_save() {
	eeprom_update_byte(EEPROM_ADDR_VERSION, 1);
	eeprom_update_byte(EEPROM_ADDR_FW_VER_MAJOR, CONFIG_FW_MAJOR);
	eeprom_update_byte(EEPROM_ADDR_FW_VER_MINOR, CONFIG_FW_MINOR);
	eeprom_update_word(EEPROM_ADDR_POS_PLUS, turnout.angle_plus);
	eeprom_update_word(EEPROM_ADDR_POS_MINUS, turnout.angle_minus);
	eeprom_update_word(EEPROM_ADDR_SENS_PLUS, turnout.sensor_plus);
	eeprom_update_word(EEPROM_ADDR_SENS_MINUS, turnout.sensor_minus);
	eeprom_update_byte(EEPROM_ADDR_MOVE_PER_TICK, switch_move_per_tick);
}

void ee_incr_moved_plus() {
	turnout.moved_plus++;
	turnout.ee_moved_plus[turnout.ee_moved_plus_mini]++;
	eeprom_write_word(EEPROM_ADDR_MOVED_PLUS + turnout.ee_moved_plus_mini,
	                  turnout.ee_moved_plus[turnout.ee_moved_plus_mini]);
	turnout.ee_moved_plus_mini = (turnout.ee_moved_plus_mini+1) % EEPROM_MOVED_COUNT;
}

void ee_incr_moved_minus() {
	turnout.moved_minus++;
	turnout.ee_moved_minus[turnout.ee_moved_minus_mini]++;
	eeprom_write_word(EEPROM_ADDR_MOVED_MINUS + turnout.ee_moved_minus_mini,
	                  turnout.ee_moved_minus[turnout.ee_moved_minus_mini]);
	turnout.ee_moved_minus_mini = (turnout.ee_moved_minus_mini+1) % EEPROM_MOVED_COUNT;
}

void ee_store_pos_plus() {
	if (turnout.ee_positions_parity) {
		// = currently is minus
		_ee_pos_change();
	}
}

void ee_store_pos_minus() {
	if (!turnout.ee_positions_parity) {
		// = currently is plus
		_ee_pos_change();
	}
}

void _ee_pos_change() {
	uint8_t i = pseudorand % EEPROM_POSITION_COUNT;
	turnout.ee_positions_parity = !turnout.ee_positions_parity;
	turnout.ee_positions[i] = !turnout.ee_positions[i];
	eeprom_write_byte(EEPROM_ADDR_POSITION + i, turnout.ee_positions[i]);
}
