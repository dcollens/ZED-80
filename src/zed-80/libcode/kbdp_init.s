; void kbdp_init()
; - set up the PS/2 keyboard driver in polling mode
kbdp_init::
    xor	    a
    ld	    (Kbd_modifiers), a	; clear keyboard modifiers
    jp	    pio_poll_init	; configure PIO for polling mode
