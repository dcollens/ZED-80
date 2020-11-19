#define _FILE_IMPL
#include "file.h"

int fseek(FILE *stream, long offset, int whence) {
    // Only support seeking in read-only files.
    if (!stream->read) return -1;

    // This size isn't correct in the case of a text file delimited by a CTRL-Z character.
    long file_size = (long)stream->block_count << CPM_BLOCK_SHIFT;
    long pos;
    switch (whence) {
	case SEEK_SET:
	    pos = 0;
	    break;
	case SEEK_CUR:
	    pos = ftell(stream);
	    break;
	case SEEK_END:
	    // Can't accurately seek from the end of a text file, since we'd have to find the
	    // CTRL-Z char first.
	    if (!stream->binary) return -1;

	    pos = file_size;
	    break;
	default:
	    return -1;
    }
    pos += offset;

    if (pos < 0 || pos > file_size) {
	return -1;
    }

    uint16_t new_block = pos >> CPM_BLOCK_SHIFT;
    if (stream->cur_block != new_block) {
	stream->cur_block = new_block;
	__frefill(stream);
    }
    stream->bufpos = (uint8_t)pos & (uint8_t)0x7F;
    stream->eof = stream->cur_block >= stream->block_count;
    return 0;
}
