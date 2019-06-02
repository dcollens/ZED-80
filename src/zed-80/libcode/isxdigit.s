; Z_flag isxdigit(uint8_t ch)
; - set Z flag iff "ch" is a digit 0-9 or A-F
; - pass "ch" in A
; - preserves A
#local
isxdigit::
    cp	    '0'
    ret	    c		; if C flag is set (A < '0'), then Z flag will be cleared too
    cp	    '9'+1
    jr	    c, yes	; A <= '9', so it's between 0 and 9
    cp	    'A'
    ret	    c		; if C flag is set (A < 'A'), then Z flag will be cleared too
    cp	    'F'+1
    jr	    c, yes	; A <= 'F', so it's between A and F
    ; otherwise, no
    or	    a		; reset Z flag (A != 0, so Z is reset)
    ret
yes:
    cp	    a		; set Z flag
    ret
#endlocal
