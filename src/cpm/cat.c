#include <stdint.h>
#include <stdio.h>
#include <string.h>
#include "fcb.h"

#define CPM_BLOCK_SIZE	    128
#define CPM_DEFAULT_IOBUF   ((uint8_t *)0x0080)

#define CTRL_Z		    ((char)0x1A)
#define MIN(a,b)	    ((a) < (b) ? (a) : (b))

static void putchars(char const *chars, size_t count) {
    while (count > 0) {
	putchar(*chars++);
	--count;
    }
}

static void fcb_zero(FCB *fcb) {
    memset(fcb, 0, sizeof(*fcb));
}

static void fcb_set_filename(FCB *fcb, char const *filename) {
    char const *dot = strchr(filename, '.');
    size_t baselen = dot == NULL ? strlen(filename) : dot - filename;

    memset(fcb->file_name, ' ', sizeof(fcb->file_name));
    memcpy(fcb->file_name, filename, MIN(baselen, sizeof(fcb->file_name)));

    memset(fcb->file_ext, ' ', sizeof(fcb->file_ext));
    if (dot != NULL) {
	char const *ext = dot + 1;
	size_t extlen = strlen(ext);
	memcpy(fcb->file_ext, ext, MIN(extlen, sizeof(fcb->file_ext)));
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
