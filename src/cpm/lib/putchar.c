#include <stdint.h>
#include <stdio.h>
#include "conio.h"

int putchar(int ch) {
    if (ch == '\n') {
	conio_putchar('\r');
    }
    conio_putchar(ch);
    return ch;
}
