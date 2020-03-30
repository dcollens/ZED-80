#include <stdlib.h>
#include <string.h>
#define _FILE_IMPL
#include "file.h"

#define MIN(a,b)	((a) < (b) ? (a) : (b))

size_t fread(void * restrict ptr, size_t size, FILE * restrict stream) {
    size_t need = size;

    if (!stream->read) return 0;

    while (!stream->eof && need > 0) {
	uint8_t *src;
	uint8_t avail;
	uint8_t chunklen;

	if (stream->bufpos >= CPM_BLOCK_SIZE) {
	    if (__frefill(stream) != 0) break;
	}
	avail = CPM_BLOCK_SIZE - stream->bufpos;
	chunklen = MIN(avail, need);
	src = &stream->iobuf[stream->bufpos];

	if (!stream->binary) {
	    uint8_t *ctrlz = memchr(src, CTRL_Z, chunklen);
	    if (ctrlz != NULL) {
		// Found EOF.
		chunklen = ctrlz - src;
		stream->eof = 1;
	    }
	}
	memcpy(ptr, src, chunklen);

	stream->bufpos += chunklen;
	if (stream->bufpos >= CPM_BLOCK_SIZE) {
	    ++stream->cur_block;
	}
	ptr = (uint8_t *)ptr + chunklen;
	need -= chunklen;
    }
    return size - need;
}
