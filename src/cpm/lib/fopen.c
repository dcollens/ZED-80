#include <stdlib.h>
#define _FILE_IMPL
#include "file.h"

FILE *fopen(const char * restrict path, const char * restrict mode) {
    FILE *fp = calloc(1, sizeof(FILE));
    if (fp == NULL) return fp;

    fcb_set_filename(&fp->fcb, path);

    switch (*mode++) {
	case 'r':
	    fp->read = 1;
	    break;
	case 'w':
	    fp->create = 1;
	    fp->write = 1;
	    break;
	case 'a':
	default:
	    goto fail;
    }

    while (1) {
	char ch = *mode;
	if (ch == '\0') break;
	if (ch == 'b') {
	    fp->binary = 1;
	} else if (ch == '+') {
	    fp->read = fp->write = 1;
	}
	++mode;
    }

    fcb_set_dma_address(fp->iobuf);
    if (fcb_open(&fp->fcb) == 0xFF) {
	if (!fp->create) goto fail;
	if (fcb_create(&fp->fcb) == 0xFF) goto fail;
    }

    fcb_file_size(&fp->fcb);
    fp->block_count = fp->fcb.random_record;
    fp->cur_block = 0;
    fp->bufpos = NO_BUFPOS;

    goto done;

fail:
    free(fp);
    fp = NULL;

done:
    fcb_set_dma_address(CPM_DEFAULT_IOBUF);
    return fp;
}
