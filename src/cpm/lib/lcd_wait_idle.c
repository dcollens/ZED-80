#include "ioports.h"
#include "lcd.h"

void lcd_wait_idle(void) {
    __asm
    001$:
	in	a, (PORT_LCDCMD)
	and	#LCDSTAT_BUSY
	jr	nz, 001$
    __endasm;
}
