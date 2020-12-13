; PIO port A ISR
; - do not modify IX or IY, or call any routine that does, as they aren't saved/restored!
#local
ISR_pioA::
    ; switch to interrupt stack
    ld	    (Interrupted_SP), sp
    ld	    sp, INTERRUPT_STACK_TOP
    ; save registers
    ex	    af, af'
    exx
    ; actual ISR body
    ld	    l, SEG_DP
    call    seg0_toggle		; toggle left dot on 7-segment display
    in	    a, (PORT_KBD)	; A = ~input_byte (shift register receives inverted bits)
    cpl				; A = input_byte
    ld	    l, a		; L = input_byte
    call    pio_srclr		; clear shift register to make it ready for next input byte
    call    kbd_scanbyte_to_keycode ; process scan byte, yielding a keycode, if any, in L
    jr	    z, done		; Z flag set, no keycode available
    ld	    a, (Kbd_modifiers)	; A = Kbd_modifiers
    and	    KMOD_RAW_MASK	; test Kbd_modifiers & KMOD_RAW_MASK == 0?
    jr	    nz, enqueue		; if KMOD_RAW_BIT is set, enqueue directly (do not cook first) 
    ld	    a, l		; pass keycode in A
    call    kbd_keycode_to_char	; convert keycode to input char, if any
    jr	    z, done		; Z flag set => no character
enqueue:
    ; At this point L has a cooked char that we need to enqueue in a kbd buffer
    ld	    a, (Kbd_input_head)	; A = head
    ld	    h, a		; H = head
    ld	    a, (Kbd_input_tail)	; A = tail
    ld	    e, a		; E = tail
    inc	    a			; A = tail + 1
    and	    KBD_BUFFER_MASK	; A = (tail + 1) & KBD_BUFFER_MASK
    cp	    h			; test head == (tail + 1) & KBD_BUFFER_MASK
    jr	    z, done		; buffer full, so drop the input byte
    ld	    b, l		; B = input char
    ld	    d, 0		; DE = tail
    ld	    hl, Kbd_input_buffer ; HL = Kbd_input_buffer
    add	    hl, de		; HL = &Kbd_input_buffer[tail]
    ld	    (hl), b		; Kbd_input_buffer[tail] = input char
    ld	    (Kbd_input_tail), a	; Kbd_input_tail = (tail + 1) & KBD_BUFFER_MASK
done:
    ; restore registers
    exx
    ex	    af, af'
    ; restore user stack
    ld	    sp, (Interrupted_SP)
    ; re-enable interrupts and return
    ei
    reti
#endlocal
