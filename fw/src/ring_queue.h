#ifndef _RING_QUEUE_H_
#define _RING_QUEUE_H_

/* Ring-buffer queue. */

#include <stdint.h>
#include <stdbool.h>

#define MAX_LENGTH 128

typedef struct {
	char data[MAX_LENGTH];
	uint8_t ptr_b;
	uint8_t ptr_e; // points after end
	bool empty;
} RingQueue;

typedef RingQueue RQ;

void rq_init(volatile RQ*);
void rq_enqueue(volatile RQ*, char value);
char rq_dequeue(volatile RQ*);
bool rq_empty(volatile RQ*);
char rq_front(volatile RQ* rq);
bool rq_full(volatile RQ*);

#endif
