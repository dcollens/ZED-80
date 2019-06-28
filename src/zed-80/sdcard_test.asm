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

; Mask of all SD-card-related bits in SYSREG. We ignore ICLR because it's not used.
SYS_SDMASK	    equ SYS_SDCLK | SYS_SDCS | SYS_SDOCLK
; Mask of SD-card clock bits in SYSREG
SYS_SDCLOCKS	    equ SYS_SDCLK | SYS_SDOCLK

; Number of cycles to poll SD card response for.
SDC_POLL_COUNT	    equ 1000

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
    ld	    hl, DATA
    ld	    bc, DATA_size
    call    bzero		    ; zero the DATA segment

    ; Set Sysreg to ensure MMUEN is on (this initializes the Sysreg variable in the data segment
    ; that we just zeroed.
    ld	    a, SYS_MMUEN | SYS_SDCS | SYS_SDICLR
    call    sysreg_write

    call    seg_init		    ; clear 7-segment display
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

    call    delay_1ms		    ; delay minimum 1ms after power-on

    ld	    de, msg_80_clocks
    call    sioA_writeln	    ; print header for next step
    ; send 80 (minimum 74) clock cycles with CS high and MOSI high
    ld	    b, 10		    ; 10 bytes = 80 bits
    ld	    a, (Sysreg)
    and	    ~SYS_SDMASK
    or	    SYS_SDCS
    call    sysreg_write	    ; set CS high (inactive), clocks idle
writeByte:
    ld	    a, 0xFF		    ; want 8 bits of MOSI high
    call    sdc_xchg		    ; write byte to SD card
    call    sioA_puthex8
    djnz    writeByte
    call    sioA_crlf
    call    sioA_crlf

    ; Send CMD0 to reset the card
    ld	    de, msg_cmd0
    call    sioA_writeln
    ld	    a, (Sysreg)
    and	    ~SYS_SDMASK
    call    sysreg_write	    ; set CS low (active), clocks idle
    ld	    hl, sdc_cmd0_data
    ld	    b, sdc_cmd0_data_len
    call    sdc_putbytes	    ; write command bytes
    ld	    bc, SDC_POLL_COUNT
    call    sdc_poll		    ; poll for completion
    call    sioA_puthex8	    ; display response byte
    call    sioA_crlf
    call    sioA_crlf

    ; Send CMD8 to determine major version, and unlock v2 features (if present)
    ld	    de, msg_cmd8
    call    sioA_writeln	    ; next we send CMD8 (assume CS low and clocks idle)
    ld	    hl, sdc_cmd8_data
    ld	    b, sdc_cmd8_data_len
    call    sdc_putbytes	    ; write command bytes
    ld	    bc, SDC_POLL_COUNT
    call    sdc_poll		    ; poll for completion
    cp	    0xFF		    ; test response == 0xFF?
    jr	    z, fail		    ; if response == 0xFF, fail
    ld	    l, a		    ; save response
    call    sioA_puthex8	    ; display response byte
    ld	    a, l		    ; restore response
    cp	    0x05		    ; test response == 0x05?
    jr	    z, sdcV1		    ; if response == 0x05, SD Card is v1
    ld	    b, 4
    call    sdc_getbytes	    ; read 5 bytes from SD card into SDC_buffer
    ld	    de, SDC_buffer
    ld	    b, 4
    call    sioA_puthex8_n	    ; display response bytes
    ld	    de, msg_sdcard_v2
    jr	    doneCmd8
sdcV1:
    ld	    de, msg_sdcard_v1
doneCmd8:
    call    sioA_crlf
    call    sioA_writeln
    call    sioA_crlf

    ; TODO: Send ACMD41 to activate card

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
    .text "Card not present", NUL
msg_card_present:
    .text "Card present", NUL
msg_wp_off:
    .text "WP off", NUL
msg_wp_on:
    .text "WP on", NUL
msg_80_clocks:
    .text "80 clocks", NUL
msg_cmd0:
    .text "CMD0", NUL
msg_cmd8:
    .text "CMD8", NUL
msg_fail:
    .text "Fail", NUL
msg_sdcard_v1:
    .text "SDcardV1", NUL
msg_sdcard_v2:
    .text "SDcardV2", NUL

sdc_cmd0_data:
    .byte $40, $00,$00,$00,$00, $95
sdc_cmd0_data_len	equ $-sdc_cmd0_data
sdc_cmd8_data:
    .byte $48, $00,$00,$01,$AA, $87
sdc_cmd8_data_len	equ $-sdc_cmd8_data
#endlocal

; uint8_t sdc_poll(uint16_t maxCount)
; - 'maxCount' in BC (0 means 65536)
; - writes up to maxCount 0xFF bytes out to the SD card
; - returns the first non-0xFF byte the card sends back, or else 0xFF
; - return card response byte in A
; - BC is decremented by the number of 0xFF's that were returned by the card
#local
sdc_poll::
loop:
    ld	    a, 0xFF		    ; write 0xFF to SD card until we get a response
    call    sdc_xchg
    cp	    0xFF		    ; test response byte == 0xFF?
    ret	    nz			    ; return if response != 0xFF
    dec	    bc			    ; --maxCount
    ld	    a, b
    or	    c
    jr	    nz, loop		    ; loop if maxCount != 0
    ld	    a, 0xFF		    ; return 0xFF
    ret
#endlocal

; void sdc_putbytes(uint8_t *data, uint8_t length)
; - 'data' in HL
; - 'length' in B (0 means 256)
; - requires SDCS to be set by caller, and will not be modified
; - B is 0 on return
#local
sdc_putbytes::
    push    hl
writeByte:
    ld	    a, (hl)
    call    sdc_xchg
    inc	    hl
    djnz    writeByte
    pop	    hl
    ret
#endlocal

; uint8_t sdc_getbytes(uint8_t length)
; - 'length' in B (0 means 256)
; - reads 'length' bytes into SDC_buffer
; - requires SDCS to be set by caller, and will not be modified
; - B is 0 on return
#local
sdc_getbytes::
    push    hl
    ld	    hl, SDC_buffer
readByte:
    ld	    a, 0xFF
    call    sdc_xchg
    ld	    (hl), a
    inc	    hl
    djnz    readByte
    pop	    hl
    ret
#endlocal

; uint8_t sdc_xchg(uint8_t data)
; - 'data' passed in A
; - writes 'data' out to SD card
; - returns byte from SD card in A
; - On entry, requires:
;   - SDCS has been set as desired by caller
;   - SDCLK and SDOCLK are both 0 (i.e. clocks are idle)
; - At exit, ensures:
;   - SDCLK and SDOCLK are both 0 (i.e. clocks are idle)
#local
sdc_xchg::
    push    bc
    out	    (PORT_SDCARD), a	    ; load SD card output shift register with 'data'
				    ; this places bit 7 on the serial output Q7 immediately
    ld	    c, PORT_SYSREG	    ; set up C so we can write to PORT_SYSREG quickly
    ld	    a, (Sysreg)
    ld	    b, a
    or	    SYS_SDOCLK		    ; A = sysreg value with CLK=0, OCLK=1
    set	    SYS_IDX_SDCLK, b	    ; B = sysreg value with CLK=1, OCLK=0

    ; Now we have a big unrolled block of output instructions, where each instruction causes a
    ; single clock transition. We note the transitions with comments. Each instruction is 2 bytes
    ; and 12 clocks. It takes two instructions to clock out one bit.
    ; Bits go out MSB (bit 7) first.
    out	    (c), b		    ; bit 7: CLK 0->1, OCLK 0->0 (SD card latches bit 7)
    out	    (c), a		    ; bit 6: CLK 1->0, OCLK 0->1 (shift bit 6 onto Q7)
    out	    (c), b		    ; bit 6: CLK 0->1, OCLK 1->0 (SD card latches bit 6)
    out	    (c), a		    ; bit 5: CLK 1->0, OCLK 0->1 (etc....)
    out	    (c), b		    ; bit 5: CLK 0->1, OCLK 1->0
    out	    (c), a		    ; bit 4: CLK 1->0, OCLK 0->1
    out	    (c), b		    ; bit 4: CLK 0->1, OCLK 1->0
    out	    (c), a		    ; bit 3: CLK 1->0, OCLK 0->1
    out	    (c), b		    ; bit 3: CLK 0->1, OCLK 1->0
    out	    (c), a		    ; bit 2: CLK 1->0, OCLK 0->1
    out	    (c), b		    ; bit 2: CLK 0->1, OCLK 1->0
    out	    (c), a		    ; bit 1: CLK 1->0, OCLK 0->1
    out	    (c), b		    ; bit 1: CLK 0->1, OCLK 1->0
    out	    (c), a		    ; bit 0: CLK 1->0, OCLK 0->1
    out	    (c), b		    ; bit 0: CLK 0->1, OCLK 1->0

    and	    ~SYS_SDCLOCKS	    ; CLK 1->0, OCLK=0
    out	    (c), a		    ; no need to write back to Sysreg, since nothing's changed
    in	    a, (PORT_SDCARD)	    ; return byte read from SD card
    pop	    bc
    ret
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

#include library "libcode"

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; data segment immediately follows code
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
#data DATA,TEXT_end
; define static variables here
SDC_buffer:: defs 32	; input buffer for sdc_getbytes

#include library "libdata"
