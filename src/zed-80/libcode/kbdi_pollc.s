; uint8_t kbdi_pollc()
; - reads the next ISO8859-1 input character from the keyboard buffer (i.e. "cooked" mode), if any
; - filters out all key-release and modifier keycodes
; - applies CTRL & SHIFT modifiers to input key
; - ignores ALT modifier (for now)
; - no character available: sets Z flag, destroys L
; - if a character is available, clears Z flag and returns character in L
#local
kbdi_pollc::
    push    bc
    push    de
    di				; disable interrupts when examining keyboard input buffer
    ld	    a, (Kbd_input_head)	; A = head
    ld	    c, a		; C = head
    ld	    a, (Kbd_input_tail)	; A = tail
    cp	    c			; test head == tail?
    jr	    z, eiReturn		; head == tail, so buffer is empty
    ex	    de, hl		; DE := HL (save HL)
    ld	    hl, Kbd_input_buffer ; HL = Kbd_input_buffer
    ld	    b, 0		; BC = head
    add	    hl, bc		; HL = &Kbd_input_buffer[head]
    ld	    l, (hl)		; L = Kbd_input_buffer[head]
    ld	    h, d		; restore H from D (saved earlier)
    ld	    a, c		; A = head
    inc	    a			; A = head + 1
    and	    KBD_BUFFER_MASK	; A = (head + 1) & KBD_BUFFER_MASK
    ld	    (Kbd_input_head), a	; Kbd_input_head = (head + 1) & KBD_BUFFER_MASK
    inc	    a			; clear Z flag, character to be returned is in L

eiReturn:
    ei
    pop	    de
    pop	    bc
    ret
#endlocal
