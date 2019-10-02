; void sioA_write(uint8_t *data, uint8_t length)
; - 'data' in DE
; - 'length' in B (0 means 256)
#local
sioA_write::
    push    bc
    push    de
    push    hl
loop:
    ld	    a, (de)	; A = *data
    ld	    l, a
    call    sioA_putc
    inc	    de
    djnz    loop
    pop	    hl
    pop	    de
    pop	    bc
    ret
#endlocal
