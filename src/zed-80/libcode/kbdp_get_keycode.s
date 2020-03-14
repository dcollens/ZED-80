; uint8_t kbdp_get_keycode()
; - reads one or more bytes from the PS/2 keyboard port, parses them and returns a KEY_xxx code
;   indicating which key was pressed/released
; - polls until a valid key event is received
; - returned keycode is in A
#local
kbdp_get_keycode::
    push    hl
nextByte:
    call    kbdp_get_byte	; L = next scan code byte
    call    kbd_scanbyte_to_keycode ; process scan byte, yielding a keycode, if any
    jr	    z, nextByte		; Z flag set => no keycode yet, get another scan byte
    ld	    a, l		; return keycode in A
    pop	    hl
    ret
#endlocal
