#include <string.h>
#include "common.h"

void memcpy_v(volatile void* dst, volatile void* src, uint8_t size) {
	memcpy((void*)dst, (void*)src, size);
}

bool hysteresis(bool previous, bool new_to_false, bool new_to_true) {
	if ((previous) && (new_to_false))
		return false;
	else if ((!previous) && (new_to_true))
		return true;
	return previous;
}
