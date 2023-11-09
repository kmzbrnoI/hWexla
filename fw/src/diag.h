#ifndef _DIAG_H_
#define _DIAG_H_

#include <stdbool.h>

#define DIAG_STREAM_VERSION 1

extern uint16_t servo_vcc_recorded_min;
extern bool servo_vcc_warn;

void diag_send(void);
void diag_read(void);

#endif
