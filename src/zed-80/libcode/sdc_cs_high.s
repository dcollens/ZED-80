; void sdc_cs_high()
; - set SD card CS high (inactive)
; - clock out one byte of 0xFF to allow the card to observe inactive CS
sdc_cs_high::
    ld	    a, (Sysreg)
    or	    SYS_SDCS
    call    sysreg_write
    ld	    a, 0xFF
    jp      sdc_xchg
