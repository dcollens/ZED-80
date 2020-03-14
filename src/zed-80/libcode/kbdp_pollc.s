; uint8_t kbdp_pollc()
; - reads the next ISO8859-1 input character from the keyboard (i.e. "cooked" mode), if any
; - filters out all key-release and modifier keycodes
; - applies CTRL & SHIFT modifiers to input key
; - ignores ALT modifier (for now)
; - no character available: sets Z flag
; - if a character is available, clears Z flag and returns character in L
#local
kbdp_pollc::
loop:
    call    kbdp_poll		; check if there's another input byte ready
    ret	    z			; if no input byte waiting, return

    call    kbdp_get_keycode	; read the next keycode into A
    call    kbd_keycode_to_char	; convert keycode to input char, if any
    ret	    nz			; Z clear => character in L
    jr	    loop		; Z set => no character, loop
#endlocal
