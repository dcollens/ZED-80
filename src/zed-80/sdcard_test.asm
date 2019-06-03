; Calling convention used in this program
; ---------------------------------------
;
; Unless otherwise noted, the first parameter, and the return value are stored as follows:
; 8 bits: L
; 16 bits: HL
; 32 bits: DEHL
;
; Callee saves/restores any modified registers.
; Caller pops arguments after call returns.
; AF registers are scratch (caller preserves, if needed).

; same as 'rom', except that the default fill byte for 'defs' etc. is 0x00
#target bin

#include "z80.inc"
#include "lcd.inc"
#include "7segdisp.inc"
#include "joystick.inc"
#include "z84c20.inc"
#include "z84c30.inc"
#include "z84c40.inc"
#include "keyboard.inc"
#include "ascii.inc"

; some macros that we have to declare before use
M_sio_puts  macro str
    push    de
    ld	    de, &str
    call    sioA_puts
    pop	    de
    endm

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; our code will load immediately above the ROM
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
#code TEXT,0x4000

; Careful, don't put anything before "init", as this is the entry point to our code.
init::
    ; zero the DATA segment
    ld	    hl, DATA
    ld	    bc, DATA_size
    call    bzero
    call    seg_init
    call    sioA_crlf
    call    sdc_test
    ret

; void sdc_test()
; - test SD card functionality
#local
sdc_test::
    push    de
    ld	    de, card_absent_msg
    in	    a, (PORT_JOY1)
    and	    JOY1_SDCD
    jr	    nz, done_cd
    ld	    de, card_present_msg
done_cd:
    call    sioA_puts
    call    sioA_crlf

    ld	    de, wp_off_msg
    in	    a, (PORT_JOY1)
    and	    JOY1_SDWP
    jr	    z, done_wp
    ld	    de, wp_on_msg
done_wp:
    call    sioA_puts
    call    sioA_crlf
    pop	    de
    ret

card_absent_msg:
    .text "Card not present", NUL
card_present_msg:
    .text "Card present", NUL
wp_off_msg:
    .text "WP off", NUL
wp_on_msg:
    .text "WP on", NUL
#endlocal

; void sioA_crlf()
; - write CRLF to port A
sioA_crlf::
    push    hl
    ld	    l, CR
    call    sioA_putc
    ld	    l, LF
    call    sioA_putc
    pop	    hl
    ret

#include library "libcode"

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; data segment immediately follows code
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
#data DATA,TEXT_end
; define static variables here
#include library "libdata"
