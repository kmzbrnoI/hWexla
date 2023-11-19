#ifndef _COMMON_H_
#define _COMMON_H_

#include <stdint.h>
#include <stdbool.h>

/* Definition of common types */

#define CONFIG_FW_MAJOR 1
#define CONFIG_FW_MINOR 2

#define EEPROM_POSITION_COUNT 16
#define EEPROM_MOVED_COUNT    8

#define RELAY_STATE_PLUS true

#define MAG_THRESHOLD_WARN 30 // 3% (1024 * 3% = ~30)
#define MAG_THRESHOLD_OK 40 // 4% (1024 * 4% = ~40)

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
	mOverride = 4,
} Mode;

extern volatile Turnout turnout;
extern volatile Mode mode;
extern volatile uint8_t pseudorand;

typedef enum {
	fNoFail = 0,
	fBadISR = 1,
	fInitServoVCC = 2,
	fServoVCC = 3,
	fDiag = 4,
	fOscCalMissing = 5,
} FailCode;

typedef union {
	uint8_t all;
	struct {
		bool servo_vcc_low : 1;
		bool servo_vcc_high : 1;
		bool wdg_reset : 1;
		bool missed_timer : 1;
	} sep;
} Warnings;

extern FailCode fail_code;
extern Warnings warnings;

void fail(FailCode);
void memcpy_v(volatile void*, volatile void*, uint8_t);

bool magnet_iswarn(void);
void override_enter(void);
void override_leave(void);

#endif
