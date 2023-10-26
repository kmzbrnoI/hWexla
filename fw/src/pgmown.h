#ifndef _PGMOWN_H_
#define _PGMOWN_H_

/* Save & read strings from & to program memory (flash). Avoid using RAM. */

#include <avr/pgmspace.h>

#define PGM_BUF_SIZE 32
#define PGMSTR(S) pgm_read_str(PSTR(S))

char* pgm_read_str(const char* str);

#endif
