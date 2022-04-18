#ifndef _COMMON_H_
#define _COMMON_H_

#include <stdint.h>
#include <stdbool.h>

/* Definition of common types */

#define CONFIG_FW_MAJOR 1
#define CONFIG_FW_MINOR 1

#define EEPROM_POSITION_COUNT 16
#define EEPROM_MOVED_COUNT    8

#define RELAY_STATE_PLUS true

#define STRINGIFY(s) #s

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
	uint16_t sensor_plus;
	uint16_t sensor_minus;
	bool save_pos;

	uint32_t moved_plus;
	uint32_t moved_minus;
	uint8_t ee_positions[EEPROM_POSITION_COUNT];
	bool ee_positions_parity; // false = even
	uint16_t ee_moved_plus[EEPROM_MOVED_COUNT];
	uint16_t ee_moved_minus[EEPROM_MOVED_COUNT];
	uint8_t ee_moved_plus_mini; // index of minimum in ee_moved_plus
	uint8_t ee_moved_minus_mini;// index of minimum in ee_moved_minus
} Turnout;

typedef enum {
	mRun = 0,
	mProgramming = 1,
	mInitializing = 2,
	mFail = 3,
} Mode;

extern volatile Turnout turnout;
extern volatile Mode mode;
extern volatile uint8_t pseudorand;
extern char fail_msg[16];

void fail(const char* msg);

#endif
