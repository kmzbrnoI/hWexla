#include "browser.h"
#include "common.h"
#include "usart_printf.h"

void browser_print() {
	// Do not use printf to make code smaller
	char buf[32];

	puts("Mode:\n");
	switch (mode) {
	case mRun: puts("mRun"); break;
	case mProgramming: puts("mProgramming"); break;
	case mInitializing: puts("mInitializing"); break;
	case mFail: puts("mFail"); break;
	}

	puts("\nTurnout:\n");
	puts("  .position=");
	switch (turnout.position) {
	case tpPlus: puts("plus"); break;
	case tpMinus: puts("minus"); break;
	case tpMovingToPlus: puts("movingToPlus"); break;
	case tpMovingToMinus: puts("movingToMinus"); break;
	}

	puts("\n  .angle=");
	itoa(turnout.angle, buf);
	puts(buf);
	puts("\n");

	/*puts("  .angle_plus=%d\n", turnout.angle_plus);
	puts("  .angle_minus=%d\n", turnout.angle_minus);
	puts("  .sensor_plus=%d\n", turnout.sensor_plus);
	puts("  .sensor_minus=%d\n", turnout.sensor_minus);
	puts("  .moved_plus=%d\n", turnout.moved_plus);
	puts("  .moved_minus=%d\n", turnout.moved_minus);*/
}
