; void snd_writeall(uint8_t *data)
; - write 16 byte values from 'data' to the 16 registers of the sound chip
#local
snd_writeall::
    push    bc
    push    de
    push    hl
    ld	    d, 0		; D = regnum
    ld	    b, 16		; B = loop count
writeNext:
    ld	    a, (hl)		; A = *data
    ld	    e, a
    call    snd_write		; snd_write(regnum, *data)
    inc	    d			; ++regnum
    inc	    hl			; ++data
    djnz    writeNext
    pop	    hl
    pop	    de
    pop	    bc
    ret
#endlocal
