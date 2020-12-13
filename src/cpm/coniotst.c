#include <stdlib.h>
#include <stdbool.h>
#include <stdint.h>
#include <stdio.h>
#include <string.h>

#define SCREEN_WIDTH	64
#define SCREEN_HEIGHT	32

static void vt100_home(void) {
    printf("\x1b[H");
}

static void draw_display(uint8_t seed) {
    vt100_home();

    for (uint8_t y = 0; y < SCREEN_HEIGHT; ++y) {
	for (uint8_t x = 0; x < SCREEN_WIDTH; ++x) {
	    putchar(' ' + ((x ^ y ^ seed) & 0x3F));
	}
	putchar('\n');
    }
}

void main(int argc, char *argv[]) {
    argc;
    argv;

    for (uint8_t seed = 0;; ++seed) {
	draw_display(seed);
    }
}
