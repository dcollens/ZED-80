; void kbd_init()
; - set up the PS/2 keyboard interface
#local
kbd_init::
    push    hl
    push    bc
    xor	    a
    ld	    (Kbd_modifiers), a	; clear keyboard modifiers
    ld	    bc, 0x0400 | PORT_PIOACTL ; configure PIO port A
    ld	    hl, pioA_cfg
    otir
    call    pio_srclr		; clear shift register at startup
    pop	    bc
    pop	    hl
    ret
pioA_cfg:
    .byte PIOC_MODE | PIOMODE_CONTROL
    .byte 0xF7	    ; A3 is an output (~SRCLR), everything else is an input
    .byte PIOC_ICTL | PIOICTL_INTDIS | PIOICTL_OR | PIOICTL_HIGH | PIOICTL_MASKNXT
    .byte 0xDF	    ; interrupt on A5 only (SRSTRT)
#endlocal
