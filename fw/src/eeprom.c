#include <avr/eeprom.h>
#include "eeprom.h"
#include "common.h"
#include "pwm_servo_gen.h"
#include "switch.h"

#define EEPROM_ADDR_VERSION                ((uint8_t*)0x00)
#define EEPROM_ADDR_POS_PLUS               ((uint16_t*)0x10)
#define EEPROM_ADDR_POS_MINUS              ((uint16_t*)0x12)
#define EEPROM_ADDR_SENS_PLUS              ((uint16_t*)0x14)
#define EEPROM_ADDR_SENS_MINUS             ((uint16_t*)0x16)
#define EEPROM_ADDR_MOVE_PER_TICK          ((uint8_t*)0x18)
#define EEPROM_ADDR_POSITION               ((uint8_t*)0x30) // size: 16 bytes
#define EEPROM_ADDR_MOVED_PLUS             ((uint16_t*)0x40) // size: 16 bytes
#define EEPROM_ADDR_MOVED_MINUS            ((uint16_t*)0x50) // size: 16 bytes

volatile bool ee_to_save = false;

void _ee_default_config() {
	turnout.angle_plus = 150;
	turnout.angle_minus = 350;
	turnout.angle = 250;
	turnout.sensor_plus = 250;
	turnout.sensor_minus = 750;
	turnout.moved_plus = 0;
	turnout.moved_minus = 0;

	for (size_t i = 0; i < EEPROM_MOVED_COUNT; i++) {
		eeprom_write_word(EEPROM_ADDR_MOVED_PLUS + 2*i, 0);
		eeprom_write_word(EEPROM_ADDR_MOVED_MINUS + 2*i, 0);
	}
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
	turnout.angle = eeprom_read_word(EEPROM_ADDR_POS_MINUS);
	if (turnout.angle > PWM_ANGLE_MAX)
		turnout.angle = PWM_ANGLE_MAX;

	turnout.sensor_plus = eeprom_read_word(EEPROM_ADDR_SENS_PLUS);
	turnout.sensor_minus = eeprom_read_word(EEPROM_ADDR_SENS_MINUS);
	switch_move_per_tick = eeprom_read_byte(EEPROM_ADDR_MOVE_PER_TICK);

	turnout.moved_plus = 0;
	turnout.moved_minus = 0;
	turnout.ee_moved_plus_mini = 0;
	turnout.ee_moved_minus_mini = 0;
	for (size_t i = 0; i < EEPROM_MOVED_COUNT; i++) {
		turnout.ee_moved_plus[i] = eeprom_read_word(EEPROM_ADDR_MOVED_PLUS + 2*i);
		turnout.moved_plus += turnout.ee_moved_plus[i];
		if (turnout.ee_moved_plus[i] < turnout.ee_moved_plus[turnout.ee_moved_plus_mini])
			turnout.ee_moved_plus_mini = i;

		turnout.ee_moved_minus[i] = eeprom_read_word(EEPROM_ADDR_MOVED_MINUS + 2*i);
		turnout.moved_minus += turnout.ee_moved_minus[i];
		if (turnout.ee_moved_minus[i] < turnout.ee_moved_minus[turnout.ee_moved_minus_mini])
			turnout.ee_moved_minus_mini = i;
	}

	turnout.angle = (turnout.position == tpPlus) ? turnout.angle_plus : turnout.angle_minus;
}

void ee_save() {
	eeprom_update_byte(EEPROM_ADDR_VERSION, 1);
	eeprom_update_word(EEPROM_ADDR_POS_PLUS, turnout.angle_plus);
	eeprom_update_word(EEPROM_ADDR_POS_MINUS, turnout.angle_minus);
	eeprom_update_word(EEPROM_ADDR_SENS_PLUS, turnout.sensor_plus);
	eeprom_update_word(EEPROM_ADDR_SENS_MINUS, turnout.sensor_minus);
	eeprom_update_byte(EEPROM_ADDR_MOVE_PER_TICK, switch_move_per_tick);
}

void ee_incr_moved_plus() {
	turnout.moved_plus++;
	turnout.ee_moved_plus[turnout.ee_moved_plus_mini]++;
	eeprom_write_word(EEPROM_ADDR_MOVED_PLUS + 2*turnout.ee_moved_plus_mini,
	                  turnout.ee_moved_plus[turnout.ee_moved_plus_mini]);
	turnout.ee_moved_plus_mini = (turnout.ee_moved_plus_mini+1) % EEPROM_MOVED_COUNT;
}

void ee_incr_moved_minus() {
	turnout.moved_minus++;
	turnout.ee_moved_minus[turnout.ee_moved_minus_mini]++;
	eeprom_write_word(EEPROM_ADDR_MOVED_MINUS + 2*turnout.ee_moved_minus_mini,
	                  turnout.ee_moved_minus[turnout.ee_moved_minus_mini]);
	turnout.ee_moved_minus_mini = (turnout.ee_moved_minus_mini+1) % EEPROM_MOVED_COUNT;
}
