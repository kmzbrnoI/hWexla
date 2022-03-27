#include "ring_queue.h"

void rq_init(volatile RQ* rq) {
	rq->ptr_b = 0;
	rq->ptr_e = 0;
	rq->empty = true;
}

void rq_enqueue(volatile RQ* rq, char value) {
	if (rq_full(rq))
		return;

	rq->data[rq->ptr_e] = value;
	rq->ptr_e = (rq->ptr_e + 1) % MAX_LENGTH;
	rq->empty = false;
}

char rq_dequeue(volatile RQ* rq) {
	if (rq_empty(rq))
		return 0;
	char value = rq->data[rq->ptr_b];
	rq->ptr_b = (rq->ptr_b + 1) % MAX_LENGTH;
	if (rq->ptr_b == rq->ptr_e)
		rq->empty = true;
	return value;
}

bool rq_empty(volatile RQ* rq) {
	return rq->empty;
}

char rq_front(volatile RQ* rq) {
	if (!rq_empty(rq))
		return rq->data[rq->ptr_b];
	return 0;
}

bool rq_full(volatile RQ* rq) {
	return (!rq->empty) && (rq->ptr_b == rq->ptr_e);
}
