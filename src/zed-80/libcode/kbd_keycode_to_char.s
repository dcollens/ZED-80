; uint8_t kbd_keycode_to_char(uint8_t keycode)
; - pass "keycode" in A
; - processes the specified keycode, applying any modifier flags as appropriate
; - returns the resulting input character, if any
; - ignores/consumes all key-release and modifier keycodes
; - applies CTRL & SHIFT modifiers to input key
; - ignores ALT modifier (for now)
; - no character available: sets Z flag, destroys L
; - if a character is available, clears Z flag and returns character in L
#local
kbd_keycode_to_char::
    bit	    KEY_RELEASED_BIT, a	; test (keycode & KEY_RELEASED_BIT) == 0?
    jr	    nz, noChar		; if bit is set, ignore the release keycode
    cp	    KMOD_MAX+1		; test keycode <= KMOD_MAX?
    jr	    c, noChar		; ignore modifier keys
    ld	    l, a		; L = keycode
    ld	    a, (Kbd_modifiers)	; A = modifiers
    and	    KMOD_CTRL_MSK	; test (A & KMOD_CTRL_MSK) != 0
    jr	    nz, doCtrl
    ld	    a, (Kbd_modifiers)	; A = modifiers
    and	    KMOD_SHIFT_MSK	; test (A & KMOD_SHIFT_MSK) != 0
    jr	    nz, doShift
    or	    l			; clear Z flag (assumes keycode != 0)
    ret

noChar:
    xor	    a			; set Z flag
    ret

doShift:			; Handle SHIFT modifier.
    ld	    a, l		; A = keycode
    sub	    KEY_SHIFT_MIN	; A = keycode - KEY_SHIFT_MIN
    ret	    c			; return key unmodified if keycode < KEY_SHIFT_MIN
				; note that if C is set here, then Z is cleared already
    ; Map key through table
    push    hl
    push    bc
    ld	    c, a
    ld	    b, 0
    ld	    hl, Key_shift_tbl	; HL = &Key_shift_tbl
    add	    hl, bc		; HL = &Key_shift_tbl[keycode - KEY_SHIFT_MIN]
    ld	    a, (hl)
    pop	    bc
    pop	    hl
    ld	    l, a
    or	    a			; clear Z flag (assumes keycode != 0)
    ret

doCtrl:				; Handle CTRL modifier.
    ld	    a, l		; A = keycode
    and	    0x1F		; keep lower 5 bits of keycode
    ld	    l, a
    inc	    a			; clear Z flag (A < 32, so this won't overflow to 0)
    ret

; Entries in this table map a keycode to the ISO8859-1 character that should be generated when
; the shift key is held down. The table has 89 entries, for keycodes $27-$7F inclusive
KEY_SHIFT_MIN	    equ 0x27
Key_shift_tbl:
    .byte '"()*+<_>?' ; $27-2F
    .byte ")!@#$%^&*(::<+>?" ; $30-3F
    .byte "@ABCDEFGHIJKLMNO" ; $40-4F
    .byte "PQRSTUVWXYZ{|}^_" ; $50-5F
    .byte "~ABCDEFGHIJKLMNO" ; $60-6F
    .byte "PQRSTUVWXYZ{|}~", $7F ; $70-7F
#endlocal
