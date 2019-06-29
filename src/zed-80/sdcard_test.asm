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

; SD card flags set in the SDC_flags variable.
SDF_PRESENT	    equ 0x01	    ; Card present?
SDF_WP		    equ 0x02	    ; Card write-protected?
SDF_V2		    equ 0x04	    ; Card v2? (Otherwise v1)
SDF_BLOCK	    equ 0x08	    ; Card uses block addresses? (Otherwise byte)

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

; void sdc_init()
; - initialize SD card driver
sdc_init::
    ld	    a, (Sysreg)
    and	    ~SYS_SDMASK
    or	    SYS_SDCS
    call    sysreg_write	    ; set CS high (inactive), clocks idle
    xor	    a
    ld	    (SDC_flags), a	    ; clear the SD card bit flags
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
    ld	    a, (SDC_flags)
    or	    SDF_PRESENT
    ld	    (SDC_flags), a	    ; set PRESENT flag
doneCD:
    call    sioA_writeln	    ; print presence/absence message

    ld	    de, msg_wp_off
    in	    a, (PORT_JOY1)
    and	    JOY1_SDWP		    ; test Write Protect (active high)
    jr	    z, doneWP		    ; if high, switch message to "on"
    ld	    de, msg_wp_on
    ld	    a, (SDC_flags)
    or	    SDF_WP
    ld	    (SDC_flags), a	    ; set WP flag
doneWP:
    call    sioA_writeln	    ; print write protect status message

    call    delay_1ms		    ; delay minimum 1ms after power-on

    ld	    de, msg_80_clocks
    call    sioA_writeln	    ; print header for next step
    call    sdc_dummy_clocks	    ; send 80 (minimum 74) clock cycles with CS high and MOSI high

    ; Send CMD0 to reset the card
    ld	    de, msg_cmd0
    call    sioA_puts
    ld	    hl, sdc_cmd0_data
    call    sdc_command		    ; send CMD0 to reset the card
    call    sioA_puthex8	    ; display response byte
    call    sioA_crlf

    ; Send CMD8 to determine major version, and unlock v2 features (if present)
    ld	    de, msg_cmd8
    call    sioA_puts
    ld	    hl, sdc_cmd8_data
    call    sdc_command_resp4	    ; next we send CMD8
    cp	    0xFF		    ; test response == 0xFF?
    jp	    z, fail		    ; if response == 0xFF, fail
    ld	    l, a
    call    sioA_puthex8	    ; display response byte
    ld	    a, l
    ld	    de, msg_sdcard_v1
    cp	    0x05		    ; test response == 0x05? (illegal command)
    jr	    z, doneCmd8		    ; if response == 0x05, SD Card is v1
    ld	    de, SDC_buffer
    ld	    b, 4
    call    sioA_puthex8_n	    ; display response bytes
    ld	    a, (SDC_flags)
    or	    SDF_V2
    ld	    (SDC_flags), a	    ; set V2 flag
    ld	    de, msg_sdcard_v2
doneCmd8:
    call    sioA_crlf
    call    sioA_writeln

    ; Send ACMD41 to activate card
    ld	    de, msg_acmd41
    call    sioA_puts		    ; next we send ACMD41 (assume CS low & clocks idle)
    call    sdc_acmd41
    ld	    l, a
    call    sioA_puthex8	    ; display response byte
    call    sioA_crlf
    ld	    a, l
    or	    a			    ; test response == 0?
    jr	    nz, fail		    ; if response != 0, fail

    ; For v2 cards, send CMD58 to determine if block vs. byte address
    ld	    a, (SDC_flags)
    and	    SDF_V2		    ; test SDC_flags & SDF_V2
    jr	    z, cardV1
    ld	    de, msg_cmd58
    call    sioA_puts
    ld	    hl, sdc_cmd58_data
    call    sdc_command_resp4	    ; send CMD58
    ld	    l, a
    call    sioA_puthex8	    ; display response byte
    call    sioA_crlf
    ld	    a, l
    or	    a			    ; test response == 0?
    jr	    nz, doneCmd58	    ; if response != 0, ignore result
    ld	    a, (SDC_buffer)
    and	    0x40		    ; test SDC_buffer[0] & 0x40?
    jr	    z, doneCmd58	    ; if SDC_buffer[0] & 0x40 == 0, card is byte addressed
    ld	    a, (SDC_flags)
    or	    SDF_BLOCK
    ld	    (SDC_flags), a	    ; set BLOCK flag
    ld	    de, msg_block_addr
    call    sioA_writeln	    ; display block addressing message
    jr	    doneCmd58

    ; For v1 cards, send CMD16 to set block length to 512
cardV1:
    ld	    de, msg_cmd16
    call    sioA_puts		    ; next we send CMD16
    ld	    hl, sdc_cmd16_data
    call    sdc_command		    ; send CMD16
    ld	    l, a
    call    sioA_puthex8	    ; display response byte
    call    sioA_crlf
    ld	    a, l
    or	    a			    ; test response == 0?
    jr	    nz, fail		    ; if response != 0, fail

doneCmd58:
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
    .text "CMD0: ", NUL
msg_cmd8:
    .text "CMD8: ", NUL
msg_acmd41:
    .text "ACMD41: ", NUL
msg_cmd58:
    .text "CMD58: ", NUL
msg_cmd16:
    .text "CMD16: ", NUL
msg_fail:
    .text "Fail", NUL
msg_sdcard_v1:
    .text "SDcardV1", NUL
msg_sdcard_v2:
    .text "SDcardV2", NUL
msg_block_addr:
    .text "BlkAddr", NUL

sdc_cmd0_data:
    .byte $40, $00,$00,$00,$00, $95
sdc_cmd8_data:
    .byte $48, $00,$00,$01,$AA, $87
sdc_cmd58_data:
    .byte $7A, $00,$00,$00,$00, $FD
sdc_cmd16_data:
    .byte $50, $00,$00,$02,$00, $01	; 512-byte block, dummy CRC
#endlocal

; void sdc_cs_low()
; - set SD card CS low (active)
; - clock out 0xFF's until we get a 0xFF response from the card
#local
sdc_cs_low::
    ld	    a, (Sysreg)
    and	    ~SYS_SDCS
    call    sysreg_write
loop:
    ld	    a, 0xFF
    call    sdc_xchg
    inc	    a			    ; test response byte == 0xFF?
    jr	    nz, loop		    ; continue while response != 0xFF
    ret
#endlocal

; void sdc_cs_high()
; - set SD card CS high (inactive)
; - clock out one byte of 0xFF to allow the card to observe inactive CS
sdc_cs_high::
    ld	    a, (Sysreg)
    or	    SYS_SDCS
    call    sysreg_write
    ld	    a, 0xFF
    jp      sdc_xchg

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
; - writes 'length' bytes from 'data' to the SD card
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

; void sdc_dummy_clocks()
; - send 80 clock cycles with CS inactive (high), and data=1
; - CS is set inactive (high) on return
#local
sdc_dummy_clocks::
    push    bc
    ld	    a, (Sysreg)
    and	    ~SYS_SDMASK
    or	    SYS_SDCS
    call    sysreg_write	    ; set CS high (inactive), clocks idle
    ld	    b, 10		    ; 10 bytes = 80 bits
writeByte:
    ld	    a, 0xFF		    ; want 8 bits of MOSI high
    call    sdc_xchg		    ; write byte to SD card
    djnz    writeByte
    pop	    bc
    ret
#endlocal

; uint8_t sdc_command(uint8_t data[6])
; - 'data' pointer in HL
; - send specified 6-byte command to SD card
; - returns response byte in A
#local
sdc_command::
    push    bc
    call    sdc_cs_high		    ; set CS inactive
    call    sdc_cs_low		    ; set CS active
    ld	    b, 6		    ; 6 command bytes
    call    sdc_putbytes	    ; write command bytes
    ld	    bc, SDC_POLL_COUNT
    call    sdc_poll		    ; poll for completion
    pop	    bc
    ret
#endlocal

; uint8_t sdc_command_resp4(uint8_t data[6])
; - 'data' pointer in HL
; - send specified 6-byte command to SD card
; - returns response byte in A
; - if command was successful, 4-byte response payload is in SDC_buffer
#local
sdc_command_resp4::
    push    bc
    call    sdc_command
    cp	    0x02		    ; test response < 0x02?
    jr	    nc, done		    ; if response >= 0x02, return fail
    ld	    b, 4
    ld	    c, a		    ; C = response
    call    sdc_getbytes	    ; read 4 bytes from SD card into SDC_buffer
    ld	    a, c		    ; A = response
done:
    pop	    bc
    ret
#endlocal

; uint8_t sdc_acmd41()
; - send ACMD41 to SD card until it replies with 0x00 (ready)
; - returns in A:
;    0x00: card is ready
;    0x01: card is idle (timed out waiting for transition to ready)
;    0xFF: timeout waiting for command response
#local
sdc_acmd41::
    push    bc
    push    de
    push    hl
    ld	    de, 10000		    ; retries = 10000
loop:
    dec	    de			    ; --retries
    ld	    a, d
    or	    e			    ; test retries == 0?
    jr	    z, timeout		    ; if retries == 0, return 0x01 (card stuck in idle)

    ld	    hl, cmd55_data
    call    sdc_command		    ; send CMD55 (APP_CMD prefix)
    cp	    0x02		    ; test response < 0x02?
    jr	    nc, done		    ; if response >= 0x02, fail

    ld	    a, (SDC_flags)
    and	    SDF_V2		    ; test SDC_flags & SDF_V2
    jr	    z, cardV1		    ; v1 card, so send 4 zero bytes (note A=0 in this case)
    ld	    a, 0x40		    ; v2 card, send 0x40, followed by 3 zero bytes
cardV1:
    ld	    hl, cmd41_data+1	    ; HL = &cmd41_data[1]
    ld	    (hl), a		    ; cmd41_data[1] = 0x00 (V1) or 0x40 (V2)
    dec	    hl			    ; HL = &cmd41_data[0]
    call    sdc_command		    ; send CMD41 (actually ACMD41 because of CMD55 prefix)
    cp	    0x01		    ; test response == 0x01?
    jr	    z, loop		    ; continue if card is still 'idle', otherwise return
done:
    pop	    hl
    pop	    de
    pop	    bc
    ret
timeout:
    ld	    a, 0x01
    jr	    done

cmd55_data:
    .byte $77, $00,$00,$00,$00, $65
cmd41_data:
    .byte $69, $00,$00,$00,$00, $01	; dummy CRC, also note byte 1 gets modified above!
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
;    call    sioA_puthex8
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
;    ld	    c, a
;    call    sioA_puthex8
;    ld	    a, c
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
SDC_flags:: defs 1	; flags describing current SD card status (SDF_xxx)
SDC_buffer:: defs 32	; input buffer for sdc_getbytes

#include library "libdata"
