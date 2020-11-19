#ifndef _CONIO_H_INCLUDED
#define _CONIO_H_INCLUDED

#include <stdint.h>

// CP/M console input (function 1). This is a cooked-mode, blocking read, with echo.
extern uint8_t conio_getchar(void);

// CP/M console output (function 2). Respects pause/resume keystrokes from the user.
extern void conio_putchar(uint8_t ch) __z88dk_fastcall;

// CP/M console status (function 11). Returns 0xFF if character is ready, or 0x00 if none.
extern uint8_t conio_poll(void);

// CP/M direct console I/O (function 6). Uncooked, no echo, ignores scroll pause/resume state.
// Returns the next input char, if any, otherwise 0x00 to indicate none was ready (non-blocking).
extern uint8_t conio_direct_pollchar(void);
// Displays 'ch'.
extern void conio_direct_putchar(uint8_t ch) __z88dk_fastcall;

#endif
