#ifndef _SIMPLE_QUEUE_H_
#define _SIMPLE_QUEUE_H_

/* Simple queue. */

#include <stdint.h>
#include <stdbool.h>

#define MAX_LENGTH 128

typedef struct {
	char data[MAX_LENGTH];
	uint8_t length;
} SimpleQueue;

typedef SimpleQueue SQ;

void sq_init(volatile SQ*);
void sq_enqueue(volatile SQ*, char value);
char sq_dequeue(volatile SQ*);
bool sq_empty(volatile SQ*);
uint8_t sq_size(volatile SQ*);
char sq_front(volatile SQ*);
bool sq_full(volatile SQ*);
bool sq_contains(volatile SQ*, char value);

#endif
