PORT_KBD	equ 0x90	    ; port address for keyboard byte input

; Single-byte key codes. These overlap with ASCII wherever possible, so that it is practical to
; just use the key value directly as input (provided you don't care about modifier keys).
; High bit set means the corresponding key was released.
KEY_NONE	equ 0x00	    ; no key
KEY_BS		equ 0x08	    ; Backspace
KEY_TAB		equ 0x09	    ; Tab
KEY_ENTER	equ 0x0D	    ; Enter/Return
KEY_RIGHT	equ 0x10	    ; Cursor right
KEY_LEFT	equ 0x11	    ; Cursor left
KEY_ESC		equ 0x1B	    ; Escape
KEY_UP		equ 0x1E	    ; Cursor up
KEY_DOWN	equ 0x1F	    ; Cursor down
KEY_SPACE	equ 0x20	    ; Space bar
KEY_APOST	equ 0x27	    ; '
KEY_COMMA	equ 0x2C	    ; ,
KEY_DASH	equ 0x2D	    ; -
KEY_DOT		equ 0x2E	    ; .
KEY_SLASH	equ 0x2F	    ; /
KEY_0		equ 0x30
KEY_1		equ 0x31
KEY_2		equ 0x32
KEY_3		equ 0x33
KEY_4		equ 0x34
KEY_5		equ 0x35
KEY_6		equ 0x36
KEY_7		equ 0x37
KEY_8		equ 0x38
KEY_9		equ 0x39
KEY_SEMI	equ 0x3B	    ; ;
KEY_EQUAL	equ 0x3D	    ; =
KEY_LSQB	equ 0x5B	    ; [
KEY_BKSL	equ 0x5C	    ; \
KEY_RSQB	equ 0x5D	    ; ]
KEY_TICK	equ 0x60	    ; `
KEY_A		equ 0x61
KEY_B		equ 0x62
KEY_C		equ 0x63
KEY_D		equ 0x64
KEY_E		equ 0x65
KEY_F		equ 0x66
KEY_G		equ 0x67
KEY_H		equ 0x68
KEY_I		equ 0x69
KEY_J		equ 0x6A
KEY_K		equ 0x6B
KEY_L		equ 0x6C
KEY_M		equ 0x6D
KEY_N		equ 0x6E
KEY_O		equ 0x6F
KEY_P		equ 0x70
KEY_Q		equ 0x71
KEY_R		equ 0x72
KEY_S		equ 0x73
KEY_T		equ 0x74
KEY_U		equ 0x75
KEY_V		equ 0x76
KEY_W		equ 0x77
KEY_X		equ 0x78
KEY_Y		equ 0x79
KEY_Z		equ 0x7A
KEY_DEL		equ 0x7F	    ; Delete

KEY_RELEASED	equ 0x80	    ; if this bit is set, the key code represents a release event
KEY_RELEASED_BIT equ 7

; Keyboard scan code parser state flags.
KBD_SCNST_IDL	equ 0x00	    ; idle, awaiting a new scan code
KBD_SCNST_EXTBIT equ 0		    ; next byte shall be looked up in extended scan code table
KBD_SCNST_RLSBIT equ 7		    ; parsed a $F0 code, indicating a key-up event
