; void sdc_cs_low()
; - set SD card CS low (active)
; - clock out 0xFF's until we get a 0xFF response from the card
sdc_cs_low::
    push    hl
    ld	    hl, ~SYS_SDCS << 8    ; clear SYS_SDCS bit
    M_sysreg_atomic_update
    pop	    hl
    jp	    sdc_wait_ready
