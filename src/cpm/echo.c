#include <stdint.h>
#include <stdio.h>

void main(int argc, char *argv[]) {
    for (int8_t i = 1; i < argc; ++i) {
	if (i > 1) {
	    putchar(' ');
	}
	printf("%s", argv[i]);
    }
    putchar('\n');
}
