; void sdc_putbytes(uint8_t *data, uint8_t length)
; - 'data' in HL
; - 'length' in B (0 means 256)
; - writes 'length' bytes from 'data' to the SD card
; - requires SDCS to be set by caller, and will not be modified
; - B is 0 on return
#local
sdc_putbytes::
    push    hl
writeByte:
    ld	    a, (hl)
    call    sdc_xchg
    inc	    hl
    djnz    writeByte
    pop	    hl
    ret
#endlocal
