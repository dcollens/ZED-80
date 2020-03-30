#include <stdlib.h>
#define _FILE_IMPL
#include "file.h"

int fgetc(FILE *stream) {
    if (stream->eof || !stream->read) return EOF;

    if (stream->bufpos == NO_BUFPOS) {
	// Need to fill the buffer.
	if (__frefill(stream) != 0) return EOF;
    }

    {
	uint8_t ch = stream->iobuf[stream->bufpos];
	if (!stream->binary && ch == CTRL_Z) {
	    stream->eof = 1;
	    return EOF;
	}

	if (++stream->bufpos >= CPM_BLOCK_SIZE) {
	    ++stream->cur_block;
	    stream->bufpos = NO_BUFPOS;
	}
	return ch;
    }
}
