#ifndef _CONIO_H_INCLUDED
#define _CONIO_H_INCLUDED

#include <stdint.h>

// CP/M console input (function 1). Processes control flow chars, blocking read, with echo.
extern uint8_t conio_getchar(void);

// CP/M console output (function 2). Respects pause/resume keystrokes from the user.
extern void conio_putchar(uint8_t ch) __z88dk_fastcall;

// CP/M console status (function 11). Returns 0xFF if character is ready, or 0x00 if none.
extern uint8_t conio_poll(void);

// CP/M direct console I/O (function 6). No echo, ignores scroll pause/resume state.
// Returns the next input char, if any, otherwise 0x00 to indicate none was ready (non-blocking).
extern uint8_t conio_direct_pollchar(void);
// Displays 'ch'.
extern void conio_direct_putchar(uint8_t ch) __z88dk_fastcall;

// ZED-80 specific CP/M CBIOS extension. Set raw or cooked mode. In raw mode, all console input
// bytes are raw key codes, with high bit set to indicate press/release status. In cooked mode,
// all console input bytes are the logical characters typed by the user (e.g. "a" or "B").
#define CONIO_INPUT_MODE_COOKED	    0
#define CONIO_INPUT_MODE_RAW	    1
extern void conio_set_input_mode(uint8_t mode) __z88dk_fastcall;

// Raw key codes.
#define KEY_NONE	0x00
#define KEY_LSHFT	0x01	    // Left shift
#define KEY_RSHFT	0x02	    // Right shift
#define KEY_LCTRL	0x03	    // Left control
#define KEY_RCTRL	0x04	    // Right control
#define KEY_LALT	0x05	    // Left alt
#define KEY_RALT	0x06	    // Right alt
#define KEY_BS		0x08	    // Backspace
#define KEY_TAB		0x09	    // Tab
#define KEY_ENTER	0x0D	    // Enter/Return
#define KEY_RIGHT	0x10	    // Cursor right
#define KEY_LEFT	0x11	    // Cursor left
#define KEY_ESC		0x1B	    // Escape
#define KEY_UP		0x1E	    // Cursor up
#define KEY_DOWN	0x1F	    // Cursor down
#define KEY_SPACE	0x20	    // Space bar
#define KEY_APOST	0x27	    // '
#define KEY_COMMA	0x2C	    // ,
#define KEY_DASH	0x2D	    // -
#define KEY_DOT		0x2E	    // .
#define KEY_SLASH	0x2F	    // /
#define KEY_0		0x30
#define KEY_1		0x31
#define KEY_2		0x32
#define KEY_3		0x33
#define KEY_4		0x34
#define KEY_5		0x35
#define KEY_6		0x36
#define KEY_7		0x37
#define KEY_8		0x38
#define KEY_9		0x39
#define KEY_SEMI	0x3B	    // ;
#define KEY_EQUAL	0x3D	    // =
#define KEY_LSQB	0x5B	    // [
#define KEY_BKSL	0x5C	    // Backslash
#define KEY_RSQB	0x5D	    // ]
#define KEY_TICK	0x60	    // `
#define KEY_A		0x61
#define KEY_B		0x62
#define KEY_C		0x63
#define KEY_D		0x64
#define KEY_E		0x65
#define KEY_F		0x66
#define KEY_G		0x67
#define KEY_H		0x68
#define KEY_I		0x69
#define KEY_J		0x6A
#define KEY_K		0x6B
#define KEY_L		0x6C
#define KEY_M		0x6D
#define KEY_N		0x6E
#define KEY_O		0x6F
#define KEY_P		0x70
#define KEY_Q		0x71
#define KEY_R		0x72
#define KEY_S		0x73
#define KEY_T		0x74
#define KEY_U		0x75
#define KEY_V		0x76
#define KEY_W		0x77
#define KEY_X		0x78
#define KEY_Y		0x79
#define KEY_Z		0x7A
#define KEY_DEL		0x7F	    // Delete

#define KEY_RELEASED_MASK	0x80	    // if this bit is set, the key code represents a release event

#endif
