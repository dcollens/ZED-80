#include <stdint.h>
#include <stdio.h>
#include <string.h>
#include "fcb.h"

#define CTRL_Z		    ((char)0x1A)

static void putchars(char const *chars, size_t count) {
    while (count > 0) {
	putchar(*chars++);
	--count;
    }
}

static void cat(char const *filename) {
    fcb_zero(CPM_DEFAULT_FCB);
    fcb_set_filename(CPM_DEFAULT_FCB, filename);

    {
	uint8_t result = fcb_open(CPM_DEFAULT_FCB);
	if (result == 0xFF) {
	    printf("Error opening %s\n", filename);
	    return;
	}
    }

    while (fcb_read_seq(CPM_DEFAULT_FCB) == 0) {
	char const *ctrlz = memchr(CPM_DEFAULT_IOBUF, CTRL_Z, CPM_BLOCK_SIZE);
	putchars(CPM_DEFAULT_IOBUF, ctrlz == NULL ? CPM_BLOCK_SIZE : ctrlz - CPM_DEFAULT_IOBUF);
    }
}

void main(int argc, char *argv[]) {
    for (int8_t i = 1; i < argc; ++i) {
	cat(argv[i]);
    }
}
