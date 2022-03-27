#include "simple_queue.h"

void sq_init(volatile SQ* sq) {
	sq->length = 0;
}

void sq_enqueue(volatile SQ* sq, char value) {
	if (sq_full(sq))
		return;

	sq->data[sq->length] = value;
	sq->length++;
}

char sq_dequeue(volatile SQ* sq) {
	if (sq_empty(sq))
		return 0;
	char value = sq->data[0];
	for (uint8_t i = 0; i < sq->length-1; i++)
		sq->data[i] = sq->data[i+1];
	sq->length--;
	return value;
}

bool sq_empty(volatile SQ* sq) {
	return sq->length == 0;
}

uint8_t sq_size(volatile SQ* sq) {
	return sq->length;
}

char sq_front(volatile SQ* sq) {
	if (!sq_empty(sq))
		return sq->data[0];
	return 0;
}

bool sq_full(volatile SQ* sq) {
	return sq->length >= MAX_LENGTH;
}

bool sq_contains(volatile SQ* sq, char value) {
	for (uint8_t i = 0; i < sq->length; i++)
		if (sq->data[i] == value)
			return true;
	return false;
}
