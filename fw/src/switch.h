#ifndef _SWITCH_H_
#define _SWITCH_H_

/* Slowly switching turnout = changing position slowly */

#include <stdbool.h>
#include "common.h"

void switch_turnout(TurnoutPos);
void switch_stop(void);
bool is_switching(void);
void switch_update(void);
void on_switch_done(void);

extern volatile uint8_t switch_move_per_tick;

#endif
