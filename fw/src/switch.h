#ifndef _SWITCH_H_
#define _SWITCH_H_

/* Slowly switching turnout = changing position slowly */

#include <stdbool.h>
#include "common.h"

void switch_turnout(TurnoutPos);
void switch_stop();
bool is_switching();
void switch_update();
void on_switch_done();

extern volatile uint8_t switch_move_per_tick;

#endif
