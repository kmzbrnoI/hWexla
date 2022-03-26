#ifndef _EEPROM_H_
#define _EEPROM_H_

#include <stdbool.h>

/* EEPROM interface
 */

extern volatile bool ee_to_save;
extern volatile bool ee_to_store_pos_plus;
extern volatile bool ee_to_store_pos_minus;

// Warning: these functions take long time to execute
void ee_load();
void ee_save();

void ee_incr_moved_plus();
void ee_incr_moved_minus();
void ee_store_pos_plus();
void ee_store_pos_minus();

#endif
