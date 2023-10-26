#ifndef _PWM_SERVO_GEN_
#define _RWM_SERVO_GEN_

/* Low-level hardware PWM generation */

#include <stdbool.h>
#include <stdint.h>

// Angle range: 0 = left; 250 = middle; 500 = right

#define PWM_ANGLE_MIN 0
#define PWM_ANGLE_MAX 500

void pwm_servo_init(void);
void pwm_servo_gen(int16_t angle);
void pwm_servo_stop(void);
bool pwm_servo_generating(void);

#endif
