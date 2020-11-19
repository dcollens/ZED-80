#define _FILE_IMPL
#include "file.h"

long ftell(FILE *stream) {
    long pos = (long)stream->cur_block << CPM_BLOCK_SHIFT;
    if (stream->bufpos != NO_BUFPOS) {
	pos += stream->bufpos;
    }
    return pos;
}
