#include <stdbool.h>
#include <string.h>
#include "fcb.h"

void fcb_get_filename(char *filename, FCB const *fcb) {
    char fch;

    // Copy up to 8 chars of file name, omitting trailing spaces and nuls.
    uint8_t i = 0;
    while (i < sizeof(fcb->file_name)) {
	fch = fcb->file_name[i++];
	if (fch == '\0' || fch == ' ') {
	    break;
	}
	*filename++ = fch;
    }

    bool dotAdded = false;

    // Copy up to 3 chars of file extension, omitting trailing spaces and nuls.
    i = 0;
    while (i < sizeof(fcb->file_ext)) {
	fch = fcb->file_ext[i++];
	if (fch == '\0' || fch == ' ') {
	    break;
	}
	if (!dotAdded) {
	    *filename++ = '.';
	    dotAdded = true;
	}
	*filename++ = fch;
    }
    *filename = '\0';
}
