; void sysreg_write(uint8_t bits)
; - 'bits' passed in A register
; - write raw bits to SYSREG
; - preserves A
; - NOTE: call this with interrupts disabled, unless you are sure no ISR will also update SYSREG
sysreg_write::
    out	    (PORT_SYSREG), a
    ld	    (Sysreg), a
    ret
