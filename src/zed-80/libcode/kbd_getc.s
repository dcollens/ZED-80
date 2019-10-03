; uint8_t kbd_getc()
; - reads the next ISO8859-1 input character from the keyboard (i.e. "cooked" mode)
; - filters out all key-release and modifier keycodes
; - applies CTRL & SHIFT modifiers to input key
; - ignores ALT modifier (for now)
; - polls indefinitely until a character is available
#local
kbd_getc::
loop:
    call    kbd_pollc		; get a cooked character, if available
    ret	    nz			; return if character available
    jr	    loop		; otherwise, continue polling
#endlocal
