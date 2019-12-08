; uint8_t sdc_getbytes(uint16_t length)
; - 'length' in BC (0 means 65536)
; - reads 'length' bytes into SDC_buffer
; - requires SDCS to be set by caller, and will not be modified
; - BC is 0 on return
#local
sdc_getbytes::
    push    hl
    ld	    hl, SDC_buffer	    ; HL = SDC_buffer
loop:
    ld	    a, 0xFF
    call    sdc_xchg		    ; read next byte
    ld	    (hl), a		    ; *buffer = byte
    inc	    hl			    ; ++buffer
    dec	    bc			    ; --length
    ld	    a, c
    or	    b
    jr	    nz, loop		    ; loop while length != 0
    pop	    hl
    ret
#endlocal
