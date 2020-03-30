#include <stdlib.h>
#define _FILE_IMPL
#include "file.h"

/* Returns zero if buffer refilled ok, non-zero otherwise */
uint8_t __frefill(FILE *stream) {
    uint8_t rc;
    uint16_t cur_block = stream->cur_block;

    if (cur_block >= stream->block_count) {
	stream->eof = 1;
	return 0xFF;
    }

    stream->fcb.random_record = cur_block;
    fcb_set_dma_address(stream->iobuf);
    rc = fcb_read_rand(&stream->fcb);
    fcb_set_dma_address(CPM_DEFAULT_IOBUF);

    if (rc != 0) return rc;
    stream->bufpos = 0;

    return 0;
}
