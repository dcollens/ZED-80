; void sysreg_update(uint8_t and, uint8_t or)
; - sets SYSREG := (SYSREG & and) | or
; - updates both the SYSREG register, and the Sysreg global
; - pass 'and' in H; pass 'or' in L
; - NOTE: call this with interrupts disabled, unless you are sure no ISR will also update SYSREG
; - see M_sysreg_atomic_update in sysreg.inc for a version that disables/enables interrupts
sysreg_update::
    ld	    a, (Sysreg)
    and	    h
    or	    l
    jp	    sysreg_write
