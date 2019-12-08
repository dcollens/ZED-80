; void sioA_write_safe(uint8_t *data, uint8_t length)
; Like siaA_write() but bytes < 32 or =127 are written as '.'
; - 'data' in DE
; - 'length' in B (0 means 256)
#local
sioA_write_safe::
    push    bc
    push    de
    push    hl
loop:
    ld	    a, (de)	; A = *data
    cp      a, 127
    jp      nc, replace
    cp      a, 32
    jp      nc, not_replace
replace:
    ld      a, '.'
not_replace:
    ld	    l, a
    call    sioA_putc
    inc	    de
    djnz    loop
    pop	    hl
    pop	    de
    pop	    bc
    ret
#endlocal
