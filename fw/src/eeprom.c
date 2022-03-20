#include <avr/eeprom.h>
#include "eeprom.h"
#include "common.h"

#define EEPROM_ADDR_VERSION                ((uint8_t*)0x00)

void ee_load() {
	uint8_t version = eeprom_read_byte(EEPROM_ADDR_VERSION);
	if (version == 0xFF) {
		// default EEPROM content → reset config
		ee_save();
		return;
	}

	//config_mtbbus_speed = eeprom_read_byte(EEPROM_ADDR_MTBBUS_SPEED);
	//if (config_mtbbus_speed > MTBBUS_SPEED_115200)
	//	config_mtbbus_speed = MTBBUS_SPEED_38400;

}

void ee_save() {
	eeprom_update_byte(EEPROM_ADDR_VERSION, 1);
}
