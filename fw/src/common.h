#ifndef _COMMON_H_
#define _COMMON_H_

#include <stdint.h>

/* Definition of common types */

typedef enum {
	tpPlus = 0,
	tpMinus = 1,
	tpMovingToPlus = 2,
	tpMovingToMinus = 3
} TurnoutPos;

typedef struct {
	TurnoutPos position;
	uint16_t angle;
	uint16_t angle_plus;
	uint16_t angle_minus;
	bool save_pos;
} Turnout;

extern volatile Turnout turnout;

#endif
