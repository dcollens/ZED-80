#include <string.h>
#include "fcb.h"

void fcb_set_filename(FCB *fcb, char const *filename) {
    char const *fp = filename;
    uint8_t i = 0;

    // Copy up to 8 chars of file name, with space padding.
    while (i < sizeof(fcb->file_name)) {
	char fch = *fp;
	if (fch == '\0' || fch == '.') {
	    fch = ' ';
	} else {
	    ++fp;
	}
	fcb->file_name[i++] = fch;
    }

    // Advance fp past dot, if any.
    while (1) {
	char fch = *fp;
	if (fch == '\0') break;

	// Skip whatever it is, dot or filename char.
	++fp;
	// If it was a dot, stop here.
	if (fch == '.') break;
    }

    // Copy up to 3 chars of file extension, with space padding.
    i = 0;
    while (i < sizeof(fcb->file_ext)) {
	char fch = *fp;
	if (fch == '\0') {
	    fch = ' ';
	} else {
	    ++fp;
	}
	fcb->file_ext[i++] = fch;
    }
}
