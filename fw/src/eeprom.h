#ifndef _EEPROM_H_
#define _EEPROM_H_

#include <stdbool.h>
#include "common.h"

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
#define EEPROM_ADDR_RESET_WANTED           ((uint8_t*)0x17)
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

/* EEPROM interface
 * Writing to EEPROM takes quite a long time, so functions like `ee_save` do
 * not block. They return true iff write if completely finished, false otherwise.
 */

extern volatile bool ee_to_save;
extern volatile bool ee_to_save_servo_vcc;
extern volatile bool ee_to_save_pos_plus;
extern volatile bool ee_to_save_pos_minus;

extern uint8_t ee_fail_count;
extern FailCode ee_last_fail;

// Warning: these functions take long time to execute
void ee_load(void);
bool ee_save(void);
bool ee_save_servo_vcc(void);

void ee_incr_moved_plus(void);
void ee_incr_moved_minus(void);
bool ee_save_pos_plus(void);
bool ee_save_pos_minus(void);

void ee_fail(FailCode);
void ee_reset_fail(void);

uint8_t ee_mode(void);

#endif
