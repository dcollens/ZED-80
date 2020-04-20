; void sdc_init()
; - initialize SD card driver
sdc_init::
    push    hl
    ld	    hl, ~SYS_SDMASK << 8 | SYS_SDCS ; clear SYS_SDMASK bits, set SYS_SDCS bit
    M_sysreg_atomic_update	    ; set CS high (inactive), clocks idle
    pop	    hl
    xor	    a
    ld	    (SDC_flags), a	    ; clear the SD card bit flags
    ret
