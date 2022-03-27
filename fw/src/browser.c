#include "browser.h"
#include "common.h"
#include "usart_printf.h"

void browser_print() {
	printf("Turnout\n");
	printf("  .position=??\n");
	printf("  .angle=%d\n", turnout.angle);
	printf("  .angle_plus=%d\n", turnout.angle_plus);
	printf("  .angle_minus=%d\n", turnout.angle_minus);
	printf("  .sensor_plus=%d\n", turnout.sensor_plus);
	printf("  .sensor_minus=%d\n", turnout.sensor_minus);
	printf("  .moved_plus=%d\n", turnout.moved_plus);
	printf("  .moved_minus=%d\n", turnout.moved_minus);
}
