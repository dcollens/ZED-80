#include <stdlib.h>
#include <stdbool.h>
#include <stdint.h>
#include <stdio.h>
#include <string.h>

#include "conio.h"

void main(int argc, char *argv[]) {
    argc;
    argv;

    puts("ESC to toggle input mode; CTRL-C to exit");

    uint8_t mode = CONIO_INPUT_MODE_COOKED;
    for (;;) {
	uint8_t ch = conio_direct_pollchar();
	if (ch == 0) continue;	// no char available

	if (mode == CONIO_INPUT_MODE_COOKED) {
	    printf("C:$%02X %c\n",
		    ch,
		    ch >= 32 ? ch : ' ');
	    // CTRL-C to exit, only from cooked mode.
	    if (ch == 0x03) break;
	} else { // CONIO_INPUT_MODE_RAW
	    bool press = (ch & KEY_RELEASED_MASK) == 0;
	    uint8_t key = ch & ~KEY_RELEASED_MASK;
	    printf("%s:$%02X %c\n",
		    press ? "DN" : "UP",
		    key,
		    key >= 32 ? key : ' ');
	}

	if (ch == 0x1B) {
	    // Escape to toggle mode.
	    mode ^= 1;
	    conio_set_input_mode(mode);
	    printf("Input mode %d\n", mode);
	}
    }

    conio_set_input_mode(CONIO_INPUT_MODE_COOKED);
}
