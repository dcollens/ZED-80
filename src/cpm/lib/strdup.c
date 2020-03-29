#include <stdlib.h>
#include <string.h>
#include "strdup.h"

char *strdup(const char *str) {
    if (str == NULL) return NULL;

    {
	size_t len = strlen(str) + 1;
	char *copy = malloc(len);
	if (copy != NULL) {
	    memcpy(copy, str, len);
	}
	return copy;
    }
}
