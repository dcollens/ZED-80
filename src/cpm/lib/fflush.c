#include <stdlib.h>
#define _FILE_IMPL
#include "file.h"

int fflush(FILE *stream) {
    if (stream == NULL) {
	puts("Error: fflush(NULL) not implemented");
	return EOF;
    }
    if (stream->write) {
	puts("Error: fflush() not implemented for write");
	return EOF;
    }
    return 0;
}
