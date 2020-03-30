#include <stdlib.h>
#include <string.h>
#define _FILE_IMPL
#include "file.h"

#define MIN(a,b)	((a) < (b) ? (a) : (b))

size_t fread(void * restrict ptr, size_t size, size_t nitems, FILE * restrict stream) {
    size_t need = size * nitems;

    if (!stream->read) return 0;

    while (!stream->eof && need > 0) {
	uint8_t *src;
	uint8_t avail;
	uint8_t chunklen;

	if (stream->bufpos == NO_BUFPOS) {
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
	ptr = (uint8_t *)ptr + chunklen;
	need -= chunklen;
    }

    if (need == 0) return nitems;

    // We had a short read.
    return nitems - (need + size - 1) / size;
}
