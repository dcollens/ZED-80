; void snd_put(uint8_t bus_cycle, uint8_t data)
; - NOTE: disables & enables interrupts around SYSREG manipulations, so don't call from ISR
; - assumes audio chip bus control bits are both 0 (i.e. SNDBUS_IDLE) upon entry
; - write 'data' to the audio chip using 'bus_cycle' (either SNDBUS_ADDR to set address register,
;   or SNDBUS_WRITE to write to the currently-addressed register)
; - pass 'bus_cycle' in L, and 'data' in H
snd_put::
    ld	    a, h		    ; A = data
    out	    (PORT_PIOBDAT), a	    ; write 'data' to PIO port B
    push    hl
    ld	    h, ~(SYS_BDIR | SYS_BC1) ; clear bus control bits
    di				    ; disable interrupts before modifying SYSREG
    call    sysreg_update	    ; set requested audio chip 'bus_cycle' bits
    ld	    l, 0		    ; clear requested bus cycle bits
    call    sysreg_update	    ; turn off audio chip bus control bits
    ei				    ; re-enable interrupts
    pop	    hl
    ret
