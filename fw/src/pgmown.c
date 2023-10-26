#include "pgmown.h"

char pgm_buf[PGM_BUF_SIZE];

char* pgm_read_str(const char* str) {
	uint8_t i = 0;
	do {
		pgm_buf[i] = pgm_read_byte(str+i);
		i++;
	} while ((pgm_buf[i-1] != 0) && (i < PGM_BUF_SIZE));
	pgm_buf[i-1] = 0;
	return pgm_buf;
}
