; uint8_t kbd_scanbyte_to_keycode(uint8_t input_byte)
; - processes input_byte from the PS/2 keyboard, updating parser state and returning any
;   resulting KEY_xxx keycode
; - no keycode available: sets Z flag, returns KEY_NONE in L
; - if a keycode is available, clears Z flag and returns keycode in L
#local
kbd_scanbyte_to_keycode::
    push    bc
    push    de
    push    hl
    ld	    a, (Kbd_scan_state)
    ld	    c, a		; C = Kbd_scan_state
    ld	    a, l		; A = input_byte
    cp	    0xF0		; test A == 0xF0? (keyup byte)
    jr	    nz, notKeyUp
    set	    KBD_SCNST_RLSBIT, c	; scan_state |= KBD_SCANST_RLS
    xor	    a			; return KEY_NONE
    jr	    return
notKeyUp:			; input_byte in A was not 0xF0
    cp	    0xE0		; test A == 0xE0?
    jr	    nz, notExtCode
    set	    KBD_SCNST_EXTBIT, c	; scan_state |= KBD_SCANST_EXT
    xor	    a			; return KEY_NONE
    jr	    return
notExtCode:			; input_byte in A was not 0xE0, nor 0xF0
    bit	    KBD_SCNST_EXTBIT, c	; test (scan_state & KBD_SCANST_EXT) == 0?
    jr	    nz, parseExt	; parse next byte as extended scan code if flag set
    ; parse input_byte in A using Kbd_scan_tbl
    cp	    Kbd_scan_tbl_sz	; test input_byte < Kbd_scan_tbl_sz?
    jr	    nc, idleAndReturn0	; input_byte out of range: ignore this byte sequence
    ld	    h, 0		; HL = input_byte
    ld	    l, a
    ld	    de, Kbd_scan_tbl
    add	    hl, de		; HL = &Kbd_scan_tbl[input_byte]
found:
    ld	    a, (hl)		; A = keycode = Kbd_scan_tbl[input_byte]
    or	    a			; test keycode == KEY_NONE?
    jr	    z, idleAndReturn	; KEY_NONE: ignore this byte sequence
    cp	    KMOD_MAX+1		; test keycode <= KMOD_MAX?
    jr	    nc, notModifier	; keycode > KMOD_MAX, so it's not a modifier key
    ld	    d, a		; D = keycode
    ld	    b, a		; B = keycode
    ld	    a, 1		; set up for: A = 1 << keycode
shift:
    sla	    a			; A <<= 1
    djnz    shift		; repeat B times
    ld	    hl, Kbd_modifiers	; HL = &Kbd_modifiers
    bit	    KBD_SCNST_RLSBIT, c	; test (scan_state & KBD_SCANST_RLS) == 0?
    jr	    nz, clearModifier	; release bit is set, so clear modifier bit
    or	    (hl)		; A |= Kbd_modifiers
    jr	    modifierDone
clearModifier:
    cpl				; A = ~A
    and	    (hl)		; A &= Kbd_modifiers
modifierDone:
    ld	    (hl), a		; Kbd_modifiers = A
    ld	    a, d		; A = keycode
notModifier:
    bit	    KBD_SCNST_RLSBIT, c	; test (scan_state & KBD_SCANST_RLS) == 0?
    jr	    z, idleAndReturn	; bit clear, return keycode
    or	    KEY_RELEASED	; keycode |= KEY_RELEASED
    jr	    idleAndReturn	; return keycode

idleAndReturn0:
    xor	    a			; return KEY_NONE
idleAndReturn:			; at this point A has a keycode ready to return, or KEY_NONE
    ld	    c, KBD_SCNST_IDL	; reset scan_state to idle
return:
    pop	    hl			; restore HL (just H, really)
    ld	    l, a		; L = keycode (from A)
    or	    a			; set Z flag if no keycode (KEY_NONE), otherwise clear Z flag
    ld	    a, c		; A = scan_state
    ld	    (Kbd_scan_state), a	; Kbd_scan_state = A
    pop	    de
    pop	    bc
    ret

parseExt:			; input_byte in A is to be parsed via Kbd_ext_tbl
    ld	    b, Kbd_ext_tbl_sz	; loop Kbd_ext_tbl_sz iterations
    ld	    hl, Kbd_ext_tbl	; HL = Kbd_ext_tbl
extLoop:
    cp	    (hl)		; test *HL == input_byte
    inc	    hl			; does not affect flags
    jr	    z, found		; if equal, continue search
    inc	    hl
    djnz    extLoop
    jr	    idleAndReturn0	; not found, discard byte sequence

; The data structure for scan code mappings is as follows:
; We use a table of 132 bytes, each corresponding to the first (or next) byte of a scan code.
; Each value in the table is one of:
;   1. A KEY_xxx value representing a recognized key. Scan code processing stops and the
;      associated key-up or key-down event is returned to the upper layer.
;   2. KEY_NONE, meaning that no scan code can begin with this prefix, which simply resets the
;      scan code parser state, ignoring any input bytes processed so far.
; Any scan code byte >= 132 (i.e. outside the table) maps to KEY_NONE.
;
; For input byte $F0, a flag is stored indicating that the resulting scan code will be for a
; key-up event, and the KEY_RELEASED flag is ORed onto the resulting scan code byte when parsing
; is complete.
;
; For input byte $E0, a second flag is stored indicating that the extended scan code table must
; be searched. (See below.)
;
Kbd_scan_tbl:
    .byte KEY_NONE, KEY_NONE, KEY_NONE, KEY_NONE, KEY_NONE, KEY_NONE, KEY_NONE, KEY_NONE    ;00-07
    .byte KEY_NONE, KEY_NONE, KEY_NONE, KEY_NONE, KEY_NONE, KEY_TAB, KEY_TICK, KEY_NONE	    ;08-0F
    .byte KEY_NONE, KEY_LALT, KEY_LSHFT, KEY_NONE, KEY_LCTRL, KEY_Q, KEY_1, KEY_NONE	    ;10-17
    .byte KEY_NONE, KEY_NONE, KEY_Z, KEY_S, KEY_A, KEY_W, KEY_2, KEY_NONE		    ;18-1F
    .byte KEY_NONE, KEY_C, KEY_X, KEY_D, KEY_E, KEY_4, KEY_3, KEY_NONE			    ;20-27
    .byte KEY_NONE, KEY_SPACE, KEY_V, KEY_F, KEY_T, KEY_R, KEY_5, KEY_NONE		    ;28-2F
    .byte KEY_NONE, KEY_N, KEY_B, KEY_H, KEY_G, KEY_Y, KEY_6, KEY_NONE			    ;30-37
    .byte KEY_NONE, KEY_NONE, KEY_M, KEY_J, KEY_U, KEY_7, KEY_8, KEY_NONE		    ;38-3F
    .byte KEY_NONE, KEY_COMMA, KEY_K, KEY_I, KEY_O, KEY_0, KEY_9, KEY_NONE		    ;40-47
    .byte KEY_NONE, KEY_DOT, KEY_SLASH, KEY_L, KEY_SEMI, KEY_P, KEY_DASH, KEY_NONE	    ;48-4F
    .byte KEY_NONE, KEY_NONE, KEY_APOST, KEY_NONE, KEY_LSQB, KEY_EQUAL, KEY_NONE, KEY_NONE  ;50-57
    .byte KEY_NONE, KEY_RSHFT, KEY_ENTER, KEY_RSQB, KEY_NONE, KEY_BKSL, KEY_NONE, KEY_NONE  ;58-5F
    .byte KEY_NONE, KEY_NONE, KEY_NONE, KEY_NONE, KEY_NONE, KEY_NONE, KEY_BS, KEY_NONE	    ;60-67
    .byte KEY_NONE, KEY_NONE, KEY_NONE, KEY_NONE, KEY_NONE, KEY_NONE, KEY_NONE, KEY_NONE    ;68-6F
    .byte KEY_NONE, KEY_NONE, KEY_NONE, KEY_NONE, KEY_NONE, KEY_NONE, KEY_ESC, KEY_NONE	    ;70-77
    .byte KEY_NONE, KEY_NONE, KEY_NONE, KEY_NONE, KEY_NONE, KEY_NONE, KEY_NONE, KEY_NONE    ;78-7F
    .byte KEY_NONE, KEY_NONE, KEY_NONE, KEY_NONE					    ;80-83
Kbd_scan_tbl_sz	    equ $-Kbd_scan_tbl

; The extended scan code table has the following format:
;     struct {
;	  uint8_t scan_byte
;         uint8_t key_code
;     } entries[Kbd_ext_tbl_sz]
;
; Entries in this table are sorted by scan_byte, so they can be searched by binary search if
; desired (but the number of entries is expected to be 5 initially, suggesting a linear search is
; fine). Any input bytes with no entry in the extended scan code table behave as if an entry
; mapping them to KEY_NONE had been found (i.e. terminate processing and discard input).
;
Kbd_ext_tbl:
    .byte 0x11, KEY_RALT
    .byte 0x14, KEY_RCTRL
    .byte 0x6B, KEY_LEFT
    .byte 0x71, KEY_DEL
    .byte 0x72, KEY_DOWN
    .byte 0x74, KEY_RIGHT
    .byte 0x75, KEY_UP
Kbd_ext_tbl_sz	    equ ($-Kbd_ext_tbl) / 2

; You may be wondering how exotic scan codes like Print Screen or Pause will be handled by the
; above tables.
;
; Print Screen ($E0,$12,$E0,$7C) will be treated as two key down events that both map to KEY_NONE
; in the extended scan code table, thus it will be ignored. Likewise, its associated key-up
; sequence will be treated as two key-up sequences that are both ignored.
;
; Pause ($E1,$14,$77,$E1,$F0,$14,$F0,$77) will be treated as a KEY_NONE ($E1) followed by
; Left Control down ($14), NumberLock down ($77), KEY_NONE ($E1), Left Control up ($F0,$14),
; and NumberLock up ($F0, $77). These will all be ignored.
#endlocal
