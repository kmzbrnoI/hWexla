#include <stddef.h>
#include <stdbool.h>
#include "switch.h"
#include "pwm_servo_gen.h"
#include "eeprom.h"
#include "io.h"

uint8_t switch_move_per_tick = 4;

static bool _switching = false;
static uint8_t _begin_remain_counter;
static uint8_t _end_remain_counter;
static TurnoutPos _target_pos;
static bool _relay_switched;
static uint16_t _middle;

#define BEGIN_REMAIN 5 // send 100 ms stable signal at end of switching
#define END_REMAIN 10 // send 200 ms stable signal at end of switching

void switch_turnout(TurnoutPos pos) {
	if ((pos == tpPlus) && ((turnout.position == tpPlus) || (turnout.position == tpMovingToPlus)))
		return;
	if ((pos == tpMinus) && ((turnout.position == tpMinus) || (turnout.position == tpMovingToMinus)))
		return;

	_switching = true;
	_target_pos = pos;
	_begin_remain_counter = 0;
	_end_remain_counter = 0;
	_relay_switched = false;

	if (turnout.angle_plus > turnout.angle_minus) {
		_middle = ((turnout.angle_plus - turnout.angle_minus) / 2) + turnout.angle_minus;
	} else {
		_middle = ((turnout.angle_minus - turnout.angle_plus) / 2) + turnout.angle_plus;
	}

	if (pos == tpPlus) {
		turnout.position = tpMovingToPlus;
		ee_incr_moved_plus();
	} else {
		turnout.position = tpMovingToMinus;
		ee_incr_moved_minus();
	}

	pwm_servo_gen(turnout.angle);
}

void switch_stop(void) {
	if (_switching) {
		_switching = false;
		pwm_servo_stop();
		on_switch_done();
	}
}

bool is_switching(void) {
	return _switching;
}

bool _dir(TurnoutPos dir) {
	return ((dir == tpMovingToPlus) | (dir == tpPlus)) != (turnout.angle_plus < turnout.angle_minus);
}

void switch_update(void) {
	if (!_switching)
		return;
	if (_begin_remain_counter < BEGIN_REMAIN) {
		_begin_remain_counter++;
		return;
	}

	if (((_target_pos == tpPlus && turnout.angle == turnout.angle_plus)) ||
		((_target_pos == tpMinus && turnout.angle == turnout.angle_minus))) {
		_end_remain_counter++;
		if (_end_remain_counter >= END_REMAIN) {
			turnout.position = _target_pos;
			switch_stop();
			return;
		}

	} else {
		bool direction = _dir(_target_pos);
		if (direction) {
			turnout.angle += switch_move_per_tick;

			if (_target_pos == tpPlus) {
				if (turnout.angle > turnout.angle_plus)
					turnout.angle = turnout.angle_plus;
			} else {
				if (turnout.angle > turnout.angle_minus)
					turnout.angle = turnout.angle_minus;
			}
		} else {
			turnout.angle -= (turnout.angle >= switch_move_per_tick) ? switch_move_per_tick : turnout.angle;

			if (_target_pos == tpPlus) {
				if (turnout.angle < turnout.angle_plus)
					turnout.angle = turnout.angle_plus;
			} else {
				if (turnout.angle < turnout.angle_minus)
					turnout.angle = turnout.angle_minus;
			}
		}

		pwm_servo_gen(turnout.angle);

		if (direction) {
			if ((turnout.angle > _middle) && (!_relay_switched)) {
				_relay_switched = true;
				set_output(PIN_RELAY_CONTROL,
				           (turnout.position == tpMovingToPlus) == RELAY_STATE_PLUS);
			}
		} else {
			if ((turnout.angle < _middle) && (!_relay_switched)) {
				_relay_switched = true;
				set_output(PIN_RELAY_CONTROL,
				           (turnout.position == tpMovingToPlus) == RELAY_STATE_PLUS);
			}
		}

	}
}
