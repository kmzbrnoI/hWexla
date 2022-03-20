#ifndef _EEPROM_H_
#define _EEPROM_H_

/* EEPROM interface
 */

// Warning: these functions take long time to execute
void ee_load();
void ee_save();
void ee_incr_plus();
void ee_incr_minus();

#endif
