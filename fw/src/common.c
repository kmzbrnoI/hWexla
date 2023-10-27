#include <string.h>
#include "common.h"

void memcpy_v(volatile void* dst, volatile void* src, uint8_t size) {
	memcpy((void*)dst, (void*)src, size);
}
