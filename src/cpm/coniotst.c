#include <stdlib.h>
#include <stdbool.h>
#include <stdint.h>
#include <stdio.h>
#include <string.h>

#include "conio.h"

#define SCREEN_WIDTH	64
#define SCREEN_HEIGHT	32

static uint16_t volatile Delay;

uint32_t volatile Global_var1;
uint32_t volatile Global_var2;

static void delay(void) {
    for (uint16_t i = 0; i < Delay; ++i) {
	Global_var1 *= Global_var2;
    }
}

static void vt100_home(void) {
    printf("\x1b[H");
}

static bool draw_display(uint8_t seed) {
    vt100_home();

    for (uint8_t y = 0; y < SCREEN_HEIGHT; ++y) {
	for (uint8_t x = 0; x < SCREEN_WIDTH; ++x) {
	    putchar(' ' + ((x ^ y ^ seed) & 0x3F));
	    delay();
	}
	putchar('\n');
	if (conio_direct_pollchar() != 0) return false;
    }
    return true;
}

void main(int argc, char *argv[]) {
    if (argc < 2) {
	puts("Usage: CONIOTST delay");
	return;
    }

    Delay = atoi(argv[1]);
    printf("Using delay %u\n", Delay);

    Global_var1 = rand() | 1;
    Global_var2 = rand() | 1;

    for (uint8_t seed = 0;; ++seed) {
	if (!draw_display(seed)) break;
    }
}
