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
#include "7segdisp.inc"
#include "joystick.inc"
#include "z84c20.inc"
#include "z84c30.inc"
#include "z84c40.inc"
#include "sysreg.inc"
#include "ascii.inc"
#include "sdcard.inc"

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; our code will load immediately above the ROM
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
#code TEXT,0x4000

; Careful, don't put anything before "init", as this is the entry point to our code.
init::
    ld	    hl, DATA
    ld	    bc, DATA_size
    call    bzero		    ; zero the DATA segment

    ; Set Sysreg to ensure MMUEN is on (this initializes the Sysreg variable in the data segment
    ; that we just zeroed.
    ld	    a, SYS_MMUEN | SYS_SDCS | SYS_SDICLR
    call    sysreg_write

    call    seg_init		    ; clear 7-segment display
    call    sdc_init		    ; initialize SD card library
    call    sioA_crlf
    call    sdc_test		    ; test SD card functions
    ret

; void sdc_test()
; - test SD card functionality
#local
sdc_test::
    push    bc
    push    de
    push    hl
    ld	    de, msg_card_absent
    in	    a, (PORT_JOY1)
    and	    JOY1_SDCD		    ; test Card Detect (active low)
    jr	    nz, doneCD		    ; if low, switch message to "present"
    ld	    de, msg_card_present
doneCD:
    call    sioA_writeln	    ; print presence/absence message

    ld	    de, msg_wp_off
    in	    a, (PORT_JOY1)
    and	    JOY1_SDWP		    ; test Write Protect (active high)
    jr	    z, doneWP		    ; if high, switch message to "on"
    ld	    de, msg_wp_on
doneWP:
    call    sioA_writeln	    ; print write protect status message

    ld	    de, msg_start_card
    call    sioA_puts		    ; print card start message
    call    sdc_start_card	    ; reset & start card (destroys BC, DE, HL)
    ld	    l, a
    call    sioA_puthex8	    ; display start card status
    call    sioA_crlf
    ld	    a, l
    cp	    SDST_OK
    jr	    nz, fail

    ld	    de, msg_card_flags
    call    sioA_puts		    ; print card flags message
    ld	    a, (SDC_flags)
    call    sioA_puthex8	    ; display card flags
    call    sioA_crlf

    ; Read sector 0, and display it.
    ld	    bc, 0
    ld	    de, 0
    call    sdc_read_sector	    ; read sector 0
    or	    a			    ; test result == 0?
    jr	    nz, fail		    ; if result != 0, fail
    ld	    bc, 512
    ld	    hl, SDC_buffer
    call    sioA_hexdump	    ; dump 512 bytes in hex

    ; Modify the sector we just read, and write it back.
    ld	    de, msg_writing
    call    sioA_writeln
    ld	    hl, SDC_buffer
    inc	    (hl)		    ; increment first byte of sector
    ld	    bc, 0
    ld	    de, 0
    call    sdc_write_sector	    ; write sector 0
    or	    a			    ; test result == 0?
    jr	    nz, fail		    ; if result != 0, fail

    ; Finally, read the modified sector 0, and display it.
    ld	    bc, 0
    ld	    de, 0
    call    sdc_read_sector	    ; read sector 0
    or	    a			    ; test result == 0?
    jr	    nz, fail		    ; if result != 0, fail
    ld	    bc, 512
    ld	    hl, SDC_buffer
    call    sioA_hexdump	    ; dump 512 bytes in hex

done:
    pop	    hl
    pop	    de
    pop	    bc
    ret

fail:
    call    sioA_crlf
    ld	    de, msg_fail
    call    sioA_writeln
    jr	    done

msg_card_absent:
    .asciz "Card not present"
msg_card_present:
    .asciz "Card present"
msg_wp_off:
    .asciz "WP off"
msg_wp_on:
    .asciz "WP on"
msg_start_card:
    .asciz "Start card: "
msg_card_flags:
    .asciz "Card flags: "
msg_fail:
    .asciz "Fail"
msg_writing:
    .asciz "Write sector 0"
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

; void sioA_writeln(uint8_t *text)
; - write the NUL-terminated string at "text" to port A, followed by CRLF
; - pass "text" in DE
sioA_writeln::
    call    sioA_puts
    jp	    sioA_crlf

; void sioA_puthex8_n(uint8_t *data, uint8_t length)
; - 'data' in DE
; - 'length' in B (0 means 256)
; - print 'length' bytes from 'data' as hexadecimal to serial port A
; - B is 0 on return
#local
sioA_puthex8_n::
    push    de
    push    hl
putByte:
    ld	    a, (de)
    call    sioA_puthex8
    inc	    de
    djnz    putByte
    pop	    hl
    pop	    de
    ret
#endlocal

; void sioA_hexdump(uint8_t *data, uint16_t length)
; - 'data' in HL
; - 'length' in BC
; - displays 'length' bytes from 'data' in hexadecimal on serial port A
#local
sioA_hexdump::
    push    bc
    push    de
    push    hl
    ; TODO: This is bogus and hardcoded for 512 bytes
    ld	    b, 32
line:
    push    bc

    ld	    de, hl
    ld	    b, 16
    call    sioA_puthex8_n

    ld	    l, ' '
    call    sioA_putc
    call    sioA_putc

    ld	    b, 16
    call    sioA_write_safe
    call    sioA_crlf

    ld	    hl, de
    ld	    de, 16
    add	    hl, de

    pop	    bc
    djnz    line

    pop	    hl
    pop	    de
    pop	    bc
    ret
#endlocal

#include library "libcode"

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; data segment immediately follows code
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
#data DATA,TEXT_end
; define static variables here

#include library "libdata"
