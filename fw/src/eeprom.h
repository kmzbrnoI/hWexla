#ifndef _EEPROM_H_
#define _EEPROM_H_

#include <stdbool.h>
#include "common.h"

/* EEPROM interface
 */

extern volatile bool ee_to_save;
extern volatile bool ee_to_save_servo_vcc;
extern volatile bool ee_to_store_pos_plus;
extern volatile bool ee_to_store_pos_minus;

extern uint8_t ee_fail_count;
extern FailCode ee_last_fail;

// Warning: these functions take long time to execute
void ee_load(void);
void ee_save(void);
void ee_save_servo_vcc(void);
void ee_save_warnings(void);

void ee_incr_moved_plus(void);
void ee_incr_moved_minus(void);
void ee_store_pos_plus(void);
void ee_store_pos_minus(void);

void ee_fail(FailCode);
void ee_reset_fail(void);

uint8_t ee_mode(void);

#endif
