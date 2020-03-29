#include <stdint.h>
#include <stdio.h>
#include "cmdline.h"

void main(int argc, char *argv[]) {
    puts("Hello world!");

    printf("Raw command-line: \"%s\"\n", __Raw_cmdline);

    printf("argc=%d\n", argc);
    for (int8_t i = 0; i < argc; ++i) {
	printf("  argv[%d]=\"%s\"\n", (int)i, argv[i]);
    }
}
