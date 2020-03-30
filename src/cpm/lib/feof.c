#include <stdlib.h>
#define _FILE_IMPL
#include "file.h"

int feof(FILE *stream) {
    return stream->eof;
}
