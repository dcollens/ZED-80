#include <stdlib.h>
#define _FILE_IMPL
#include "file.h"

int fclose(FILE *stream) {
    fflush(stream);
    if (stream->write) {
	fcb_close(&stream->fcb);
    }
    free(stream);
    return 0;
}
