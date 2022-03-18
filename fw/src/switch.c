#include <stddef.h>
#include <stdbool.h>
#include "switch.h"
#include "pwm_servo_gen.h"

bool _switching = false;
volatile uint16_t switch_move_per_tick = 10;
volatile TurnoutPos _target_pos;
volatile uint8_t end_remain_counter;
volatile uint8_t begin_remain_counter;

#define BEGIN_REMAIN 5 // send 100 ms stable signal at end of switching
#define END_REMAIN 10 // send 200 ms stable signal at end of switching

void switch_turnout(TurnoutPos pos) {
	_switching = true;
	_target_pos = pos;
	begin_remain_counter = 0;
	end_remain_counter = 0;

	if (pos == tpPlus)
		turnout.position = tpMovingToPlus;
	else
		turnout.position = tpMovingToMinus;

	pwm_servo_gen(turnout.angle);
}

void switch_stop() {
	if (_switching) {
		_switching = false;
		pwm_servo_stop();
		on_switch_done();
	}
}

bool is_switching() {
	return _switching;
}

bool _dir(TurnoutPos dir) {
	return ((dir == tpMovingToPlus) | (dir == tpPlus)) != (turnout.angle_plus < turnout.angle_minus);
}

void switch_update() {
	if (!_switching)
		return;
	if (begin_remain_counter < BEGIN_REMAIN) {
		begin_remain_counter++;
		return;
	}

	if (((_target_pos == tpPlus && turnout.angle == turnout.angle_plus)) ||
		((_target_pos == tpMinus && turnout.angle == turnout.angle_minus))) {
		end_remain_counter++;
		if (end_remain_counter >= END_REMAIN) {
			turnout.position = tpPlus;
			switch_stop();
			return;
		}

	} else {
		if (_dir(_target_pos)) {
			turnout.angle += switch_move_per_tick;

			if (_target_pos == tpPlus) {
				if (turnout.angle > turnout.angle_plus)
					turnout.angle = turnout.angle_plus;
			} else {
				if (turnout.angle > turnout.angle_minus)
					turnout.angle = turnout.angle_minus;
			}
		} else {
			turnout.angle -= switch_move_per_tick;

			if (_target_pos == tpPlus) {
				if (turnout.angle < turnout.angle_plus)
					turnout.angle = turnout.angle_plus;
			} else {
				if (turnout.angle < turnout.angle_minus)
					turnout.angle = turnout.angle_minus;
			}
		}

		pwm_servo_gen(turnout.angle);
	}
}
