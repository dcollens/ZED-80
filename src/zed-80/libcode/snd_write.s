; void snd_write(uint8_t addr, uint8_t data)
; - write 'data' to 'addr' on the sound chip
; - 'addr' in D, 'data' in E
snd_write::
    push    hl
    ld	    h, d
    ld	    l, SNDBUS_ADDR
    call    snd_put		; snd_put(SNDBUS_ADDR, addr)
    ld	    h, e
    ld	    l, SNDBUS_WRITE
    call    snd_put		; snd_put(SNDBUS_WRITE, data)
    pop	    hl
    ret
