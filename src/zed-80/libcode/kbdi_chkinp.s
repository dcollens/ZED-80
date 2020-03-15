; void kbdi_chkinp()
; - tests whether any cooked input characters are waiting to be read via pollc/getc
; - no character available: sets Z flag
; - character available: clears Z flag
kbdi_chkinp::
    push    bc
    di				; disable interrupts when examining keyboard input buffer
    ld	    a, (Kbd_input_head)	; A = head
    ld	    c, a		; C = head
    ld	    a, (Kbd_input_tail)	; A = tail
    ei
    cp	    c			; test head == tail?
    pop	    bc
    ret
