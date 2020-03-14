; void pio_intr_init()
; - initialize PIO chip for use in interrupt-driven mode, with ISR at "IVT_PIOA"
#local
pio_intr_init::
    push    hl
    push    bc
    ld	    bc, 0x0500 | PORT_PIOACTL ; configure PIO port A
    ld	    hl, pioA_cfg
    otir
    call    pio_srclr		; clear shift register at startup
    pop	    bc
    pop	    hl
    ret

pioA_cfg:
    .byte PIOC_MODE | PIOMODE_CONTROL
    .byte 0xF7	    ; A3 is an output (~SRCLR), everything else is an input
    .byte PIOC_IVEC | lo(IVT_PIOA)  ; set IV to IVT_PIOA
    .byte PIOC_ICTL | PIOICTL_INTENA | PIOICTL_OR | PIOICTL_HIGH | PIOICTL_MASKNXT
    .byte 0xDF	    ; interrupt on A5 only (SRSTRT)
#endlocal
