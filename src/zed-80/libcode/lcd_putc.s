; void lcd_putc(uint8_t ch)
; - write the single character in "ch" to LCD
#local
VT100_STATE_NORMAL      equ 0 ; not parsing VT100 sequence
VT100_STATE_EXP_BRACKET equ 1 ; got ESC, waiting for [
VT100_STATE_EXP_START   equ 2 ; start of a parameter (digit) or command (letter) or semicolon
VT100_STATE_EXP_REST    equ 3 ; rest of a parameter (digit) or command (letter) or semicolon
lcd_putc::
    ld	    a, l		; A := ch
    cp	    CR			; Carriage return?
    jr	    nz, notCR
    jp	    lcd_cr
notCR:
    cp	    LF			; Line feed?
    jr	    nz, notLF
    jp	    lcd_lf
notLF:
    cp	    ASC_BS		; Backspace?
    jr	    nz, notBS
    jp	    lcd_bs
notBS:
    cp	    ESC     		; Escape?
    jr	    nz, notESC
    ld      a, VT100_STATE_EXP_BRACKET
    ld      (vt100_state), a
    ret
notESC:
    ; See if we're doing VT100 parsing.
    ld      a, (vt100_state)
    cp      VT100_STATE_EXP_BRACKET
    jr      z, expecting_bracket
    cp      VT100_STATE_EXP_START
    jr      z, expecting_start_of_parameter
    cp      VT100_STATE_EXP_REST
    jr      z, expecting_rest_of_parameter

    ; Normal write.
    M_out   (PORT_LCDCMD), LCDREG_MRWDP
wait_fifo_room:
    ; wait until memory FIFO is non-full
    in	    a, (PORT_LCDCMD)
    and	    LCDSTAT_WRFULL
    jr	    nz, wait_fifo_room
    ; write output character
    ld	    a, l
    out	    (PORT_LCDDAT), a	; send byte to LCD panel
    jp	    lcd_wait_idle

; The rest of this file is the VT100 parser. Most of the information
; is from: https://vt100.net/emu/dec_ansi_parser

; One of the VT100_STATE_... constants.
vt100_state: defb 0
; Number of parameters in this command so far.
vt100_param_count: defb 0
; Values of the parameters. Zero means "use the default value". Spec say max of 16.
vt100_params: defs 16

expecting_bracket:
    ld      a, l
    cp      '['
    jr      nz, not_bracket
    xor     a
    ld      (vt100_param_count), a
    ld      a, VT100_STATE_EXP_START
    ld      (vt100_state), a
    ret
not_bracket:
    ld      a, VT100_STATE_NORMAL
    ld      (vt100_state), a
    ret

expecting_start_of_parameter:
    ld      a, l
    cp      ';'
    jr      nz, not_semicolon_start
    push    hl
    call    make_new_param
    pop     hl
    ret
not_semicolon_start:
    cp      '0'
    jr      c, execute
    cp      '9'+1
    jr      nc, execute
    ; Digit.
    push    af
    call    make_new_param
    pop     af
    sub     '0'
    ld      (hl), a
    ld      a, VT100_STATE_EXP_REST
    ld      (vt100_state), a
    ret

expecting_rest_of_parameter:
    ld      a, l
    cp      ';'
    jr      nz, not_semicolon_rest
    ld      a, VT100_STATE_EXP_START
    ld      (vt100_state), a
    ret
not_semicolon_rest:
    cp      '0'
    jr      c, execute
    cp      '9'+1
    jr      nc, execute
    ; Digit.
    sub     '0'
    push    de
    push    hl
    push    bc
    ld      d, a
    ld      a, (vt100_param_count)
    dec     a
    ld      hl, vt100_params
    ld      b, 0
    ld      c, a
    add     hl, bc
    ; Get current parameter value.
    ld      a, (hl)
    ; Multiply by 10.
    sla     a
    ld      b, a
    sla     a
    sla     a
    add     b
    ; Add new value.
    add     d
    ld      (hl), a
    pop     bc
    pop     hl
    pop     de
    ret

execute:
    ld      a, VT100_STATE_NORMAL
    ld      (vt100_state), a
    ret

; Adds a new parameter, set its value to zero. Does not check for parameter
; list overflow. Returns a pointer to the new parameter in HL.
make_new_param:
    push    bc
    ld      a, (vt100_param_count)
    ld      hl, vt100_params
    ld      b, 0
    ld      c, a
    add     hl, bc
    ld      (hl), 0
    inc     a
    ld      (vt100_param_count), a
    pop     bc
    ret

#endlocal
