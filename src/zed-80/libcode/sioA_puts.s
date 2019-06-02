; void sioA_puts(uint8_t *text)
; - write the NUL-terminated string at "text" to port A
; - pass "text" in DE
#local
sioA_puts::
    push    hl
    push    de
nextByte:
    ld	    a, (de)
    inc	    de
    or	    a		; fast test a==0
    jr	    z, done
    ld	    l, a
    call    sioA_putc
    jr	    nextByte
done:
    pop	    de
    pop	    hl
    ret
#endlocal
