; void kbdi_init()
; - set up the PS/2 keyboard driver in interrupt-driven mode
kbdi_init::
    xor	    a
    ld	    (Kbd_modifiers), a	; clear keyboard modifiers
    ld	    (Kbd_scan_state), a ; clear scan-code parser state
    jp	    pio_intr_init	; configure PIO for interrupt-driven mode
