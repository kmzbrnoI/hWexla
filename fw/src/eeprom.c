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

// TODO: this needs to be split on multiple bytes
// TODO: save position only
#define EEPROM_ADDR_ANGLE                  ((uint16_t*)0x20)

volatile bool ee_to_save = false;

void _ee_default_config() {
	turnout.angle_plus = 150;
	turnout.angle_minus = 350;
	turnout.angle = 250;
	turnout.sensor_plus = 250;
	turnout.sensor_minus = 750;
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
}

void ee_save() {
	eeprom_update_byte(EEPROM_ADDR_VERSION, 1);
	eeprom_update_word(EEPROM_ADDR_POS_PLUS, turnout.angle_plus);
	eeprom_update_word(EEPROM_ADDR_POS_MINUS, turnout.angle_minus);
	eeprom_update_word(EEPROM_ADDR_ANGLE, turnout.angle);
	eeprom_update_word(EEPROM_ADDR_SENS_PLUS, turnout.sensor_plus);
	eeprom_update_word(EEPROM_ADDR_SENS_MINUS, turnout.sensor_minus);
	eeprom_update_byte(EEPROM_ADDR_MOVE_PER_TICK, switch_move_per_tick);
}
