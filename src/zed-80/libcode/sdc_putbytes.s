; void sdc_putbytes(uint8_t *data, uint16_t length)
; - 'data' in HL
; - 'length' in BC (0 means 65536)
; - writes 'length' bytes from 'data' to the SD card
; - requires SDCS to be set by caller, and will not be modified
; - BC is 0 on return
; - HL is data + length on return
#local
sdc_putbytes::
writeByte:
    ld	    a, (hl)		    ; A = *data
    call    sdc_xchg		    ; write byte to card
    inc	    hl			    ; ++data
    dec	    bc			    ; --length
    ld	    a, c
    or	    b			    ; test length == 0?
    jr	    nz, writeByte	    ; if length != 0, write next byte
    ret
#endlocal
