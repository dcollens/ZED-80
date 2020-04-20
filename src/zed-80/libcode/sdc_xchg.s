; uint8_t sdc_xchg(uint8_t data)
; - 'data' passed in A
; - writes 'data' out to SD card
; - returns byte from SD card in A
; - On entry, requires:
;   - SDCS has been set as desired by caller
;   - SDCLK and SDOCLK are both 0 (i.e. clocks are idle)
; - At exit, ensures:
;   - SDCLK and SDOCLK are both 0 (i.e. clocks are idle)
#local
sdc_xchg::
    push    bc
    out	    (PORT_SDCARD), a	    ; load SD card output shift register with 'data'
				    ; this places bit 7 on the serial output Q7 immediately
    ld	    c, PORT_SYSREG	    ; set up C so we can write to PORT_SYSREG quickly
    di				    ; disable interrupts for atomic access to SYSREG (and Sysreg)
    ld	    a, (Sysreg)
    ld	    b, a
    or	    SYS_SDOCLK		    ; A = sysreg value with CLK=0, OCLK=1
    set	    SYS_IDX_SDCLK, b	    ; B = sysreg value with CLK=1, OCLK=0

    ; Now we have a big unrolled block of output instructions, where each instruction causes a
    ; single clock transition. We note the transitions with comments. Each instruction is 2 bytes
    ; and 12 clocks. It takes two instructions to clock out one bit.
    ; Bits go out MSB (bit 7) first.
    out	    (c), b		    ; bit 7: CLK 0->1, OCLK 0->0 (SD card latches bit 7)
    out	    (c), a		    ; bit 6: CLK 1->0, OCLK 0->1 (shift bit 6 onto Q7)
    out	    (c), b		    ; bit 6: CLK 0->1, OCLK 1->0 (SD card latches bit 6)
    out	    (c), a		    ; bit 5: CLK 1->0, OCLK 0->1 (etc....)
    out	    (c), b		    ; bit 5: CLK 0->1, OCLK 1->0
    out	    (c), a		    ; bit 4: CLK 1->0, OCLK 0->1
    out	    (c), b		    ; bit 4: CLK 0->1, OCLK 1->0
    out	    (c), a		    ; bit 3: CLK 1->0, OCLK 0->1
    out	    (c), b		    ; bit 3: CLK 0->1, OCLK 1->0
    out	    (c), a		    ; bit 2: CLK 1->0, OCLK 0->1
    out	    (c), b		    ; bit 2: CLK 0->1, OCLK 1->0
    out	    (c), a		    ; bit 1: CLK 1->0, OCLK 0->1
    out	    (c), b		    ; bit 1: CLK 0->1, OCLK 1->0
    out	    (c), a		    ; bit 0: CLK 1->0, OCLK 0->1
    out	    (c), b		    ; bit 0: CLK 0->1, OCLK 1->0

    and	    ~SYS_SDCLOCKS	    ; CLK 1->0, OCLK=0
    out	    (c), a		    ; no need to write back to Sysreg, since nothing's changed
    ei				    ; re-enable interrupts
    in	    a, (PORT_SDCARD)	    ; return byte read from SD card
    pop	    bc
    ret
#endlocal
