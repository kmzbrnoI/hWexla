#include <avr/eeprom.h>
#include "eeprom.h"
#include "common.h"
#include "pwm_servo_gen.h"

#define EEPROM_ADDR_VERSION                ((uint8_t*)0x00)
#define EEPROM_ADDR_POS_PLUS               ((uint16_t*)0x10)
#define EEPROM_ADDR_POS_MINUS              ((uint16_t*)0x12)

void _ee_default_config() {
	turnout.angle_plus = 150;
	turnout.angle_minus = 350;
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
}

void ee_save() {
	eeprom_update_byte(EEPROM_ADDR_VERSION, 1);
	eeprom_update_word(EEPROM_ADDR_POS_PLUS, turnout.angle_plus);
	eeprom_update_word(EEPROM_ADDR_POS_MINUS, turnout.angle_minus);
}
