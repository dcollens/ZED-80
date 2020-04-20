; void sdc_cs_high()
; - set SD card CS high (inactive)
; - clock out one byte of 0xFF to allow the card to observe inactive CS
sdc_cs_high::
    push    hl
    ld	    hl, 0xFF00 | SYS_SDCS   ; preserve all bits, set SYS_SDCS bit
    M_sysreg_atomic_update
    pop	    hl
    ld	    a, 0xFF
    jp      sdc_xchg
