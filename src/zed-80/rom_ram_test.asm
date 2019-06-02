; Calling convention used in this file
; ------------------------------------
;
; Unless otherwise noted, the first parameter, and the return value are stored as follows:
; 8 bits: L
; 16 bits: HL
; 32 bits: DEHL
;
; Callee saves/restores any modified registers.
; Caller pops arguments after call returns.
; AF registers are scratch (caller preserves, if needed).

; same as 'bin', except that the default fill byte for 'defs' etc. is 0xff
#target rom

#include "sysreg.inc"
#include "mmu.inc"
#include "7segdisp.inc"
#include "joystick.inc"
#include "keyboard.inc"
#include "sound.inc"
#include "z84c20.inc"
#include "z84c30.inc"
#include "z84c40.inc"

; We set up the MMU so the Z80's memory map is as follows:
; PG0: 0x0000-0x3FFF ROM physical page 0 (ROM page 0)
; PG1: 0x4000-0x7FFF RAM physical page 8 (RAM page 0)
; PG2: 0x8000-0xBFFF RAM physical page 9 (RAM page 1)
; PG3: 0xC000-0xFFFF RAM physical page A (RAM page 2)

#code ROM, 0, 0x4000

; reset vector
RST0::
    di
    jp	    init
    defs    0x08-$

RST1::
    reti
    defs    0x10-$

RST2::
    reti
    defs    0x18-$

RST3::
    reti
    defs    0x20-$

RST4::
    reti
    defs    0x28-$

RST5::
    reti
    defs    0x30-$

RST6::
    reti
    defs    0x38-$

; maskable interrupt handler in interrupt mode 1:
RST7::
    reti

; non maskable interrupt:
; e.g. call debugger and on exit resume.
    defs    0x66-$
NMI::
    retn

; Empty ISR for interrupts we want to ignore
ISR_nop::
    ei
    reti

    defs    0x80-$
; Interrupt Vector Table
IVT::
; Table starts at 0x0080
; CTC has first 4 slots, so CTC Interrupt Vector register should be 0x80
    .word   ISR_nop	    ; CTC channel 0
    .word   ISR_nop	    ; CTC channel 1
    .word   ISR_nop	    ; CTC channel 2
    .word   ISR_ctc3	    ; CTC channel 3
; TODO: ISRs for PIO & SIO

; Set the mode for PIO port B. 'mode' is one of the PIOMODE_xxx constants.
M_pio_set_portB_mode	macro mode
    ld	    a, PIOC_MODE | &mode
    out	    (PORT_PIOBCTL), a
    endm

; void init()
init::
    ; Need to initialize MMU without use of RAM, so be careful here
    xor	    a
    out	    (PORT_MMUPG0), a	; map frame 0 to 1st page of ROM
    ld	    a, MMU_RAM_BASE
    out	    (PORT_MMUPG1), a	; map frame 1 to 1st page of RAM
    ld	    a, MMU_RAM_BASE + 1
    out	    (PORT_MMUPG2), a	; map frame 2 to 2nd page of RAM
    ld	    a, MMU_RAM_BASE + 2
    out	    (PORT_MMUPG3), a	; map frame 3 to 3rd page of RAM
    ld	    a, SYS_MMUEN | SYS_SDCS | SYS_SDICLR
    out	    (PORT_SYSREG), a	; enable MMU
    ld	    (Sysreg), a
    ; set up a stack
    ld	    sp, RAM_end-1
    ; set up interrupts
    ld	    a, hi(IVT)
    ld	    i, a	    ; I gets high byte of IVT address
    im	    2		    ; select interrupt mode 2
    ei
    call    seg_init
    call    snd_test	    ; boot sound
;    call    ctc_test	    ; need to set up CTC to get SIO working (need baud rate gen)
;    call    sio_test
    call    figure8
;    call    countup
;    call    pio_test
    call    joy_test	    ; may as well run the joystick test if we get here
    jr	    $		    ; loop forever

; void countup()
#local
countup::
    push    hl
    ld	    h, 0	; counter in h
; increment count every 500ms and toggle DP
forever:
    ld	    a, h
    call    seg_writehex    ; display counter
    ld	    l, SEG_DP
    call    seg0_toggle	    ; toggle DP
    ld	    l, 250
    call    delay_ms	    ; delay 250ms
    call    delay_ms	    ; delay 250ms
    inc	    h
    jr	    forever
    pop	    hl
    ret
#endlocal

; void figure8()
#local
figure8::
    push    hl
    push    bc
; step fig8 every 125ms; toggle DP every 1s
forever:
    ld	    b, 7
fig8_loop:
    ld	    l, b
    call    seg0_fig8
    ld	    l, 125
    call    delay_ms
    dec	    b
    jp	    p, fig8_loop
    ld	    l, SEG_DP
    call    seg0_toggle
    jr	    forever
    pop	    bc
    pop	    hl
    ret
#endlocal

; void pio_test()
#local
pio_test::
    push    hl
    push    bc
    ; configure PIO ports A and B
    ld	    bc, 0x0400 | PORT_PIOACTL
    ld	    hl, pioA_cfg
    otir
; Don't configure port B here -- it's used for the audio chip
;    ld	    bc, 0x0300 | PORT_PIOBCTL
    ; HL already points to pioB_cfg
;    otir
    call    pio_srclr		; clear shift register at startup
forever:
    ld	    l, SEG_DP
    call    seg1_toggle
    in	    a, (PORT_PIOADAT)	; read PIO port A
    cpl				; invert SRPRTY and SRSTRT signals
    bit	    5, a		; if SRSTRT is high, keep polling
    jr	    nz, forever
    ; put SRPRTY onto segment 0's DP
    and	    0x10		; mask off other bits
    add	    a, a
    add	    a, a
    add	    a, a		; shift SRPRTY left 3 bits to bit 7 (SEG_DP)
    call    seg0_write
    ; read keyboard latch, displaying hex value after inverting
    in	    a, (PORT_KBD)
    cpl
    ld	    l, a
    call    pio_srclr		; clear shift register to prepare for next byte
    ld	    a, l
    call    seg_writehex
    jr	    forever
    pop	    bc
    pop	    hl
    ret
pioA_cfg:
    .byte PIOC_MODE | PIOMODE_CONTROL
    .byte 0xF7	    ; A3 is an output (~SRCLR), everything else is an input
    .byte PIOC_ICTL | PIOICTL_INTDIS | PIOICTL_OR | PIOICTL_HIGH | PIOICTL_MASKNXT
    .byte 0xDF	    ; interrupt on A5 only (SRSTRT)
pioB_cfg:
    .byte PIOC_MODE | PIOMODE_CONTROL
    .byte 0xFF	    ; everything is an input
    .byte PIOC_ICTL | PIOICTL_INTDIS | PIOICTL_OR | PIOICTL_HIGH
#endlocal

; void sio_test()
#local
sio_test::
    push    hl
    push    bc
    ; configure SIO port A
    ld	    bc, 0x0700 | PORT_SIOACTL
    ld	    hl, sioA_cfg
    otir
    ; configure SIO port B
    ld	    bc, 0x0700 | PORT_SIOBCTL
    ld	    hl, sioA_cfg
    otir
forever:
    ; wait for an input character
waitRX:
    in	    a, (PORT_SIOACTL)
    bit	    SIORR0_IDX_RCA, a
    jr	    nz, doRXA
    in	    a, (PORT_SIOBCTL)
    bit	    SIORR0_IDX_RCA, a
    jr	    z, waitRX
doRXB:
    ; read input character
    in	    a, (PORT_SIOBDAT)
    ld	    l, a
waitTXB:
    ; wait until transmitter is idle
    in	    a, (PORT_SIOBCTL)
    bit	    SIORR0_IDX_TBE, a
    jr	    z, waitTXB
    ; write output character
    ld	    a, l
    out	    (PORT_SIOBDAT), a	; send byte out serial port
    jr	    writeSeg
doRXA:
    ; read input character
    in	    a, (PORT_SIOADAT)
    ld	    l, a
waitTXA:
    ; wait until transmitter is idle
    in	    a, (PORT_SIOACTL)
    bit	    SIORR0_IDX_TBE, a
    jr	    z, waitTXA
    ; write output character
    ld	    a, l
    out	    (PORT_SIOADAT), a	; send byte out serial port
writeSeg:
    ; write it to the 7-segment display
    call    seg_writehex
    ld	    l, SEG_DP		; toggle DP on segment 0
    call    seg0_toggle
    ; repeat
    jr	    forever
    pop	    bc
    pop	    hl
    ret
sioA_cfg:
    .byte SIOWR0_CMD_RST_CHAN
    .byte SIOWR0_PTR_R4
    .byte SIOWR4_TXSTOP_1 | SIOWR4_CLK_x16	; x16=38400bps, x64=9600bps
    ; No need to set up WR1/WR2, as they are only used for interrupts
    .byte SIOWR0_PTR_R3
    .byte SIOWR3_RXENA | SIOWR3_RX_8_BITS
    .byte SIOWR0_PTR_R5
    .byte SIOWR5_RTS | SIOWR5_TXENA | SIOWR5_TX_8_BITS | SIOWR5_DTR
    ; No need to set up WR6/WR7, as they are only used for synchronous modes
#endlocal

; void ctc_test()
#local
ctc_test::
    ; load CTC Interrupt Vector Register
    ld	    a, lo(IVT)	    ; CTC interrupt vectors are the first 4 in the IVT
    out	    (PORT_CTCIVEC), a
    ; channel 0 is the baud rate generator for serial 0
    ld	    a, CTC_CONTROL | CTC_RESET | CTC_TIMENXT | CTC_RISING | CTC_MODECTR
    out	    (PORT_CTC0), a
    ld	    a, 3	    ; 1.8432MHz divided by 3 is 614.4kHz (SIO at x64 gives 9600 baud)
    out	    (PORT_CTC0), a
    ; channel 1 is the baud rate generator for serial 1
    ld	    a, CTC_CONTROL | CTC_RESET | CTC_TIMENXT | CTC_RISING | CTC_MODECTR
    out	    (PORT_CTC1), a
    ld	    a, 3	    ; 1.8432MHz divided by 3 is 614.4kHz (SIO at x64 gives 9600 baud)
    out	    (PORT_CTC1), a
    ; channel 2 is used as a timer to divide down the system clock for channel 3
    ld	    a, CTC_CONTROL | CTC_RESET | CTC_TIMENXT | CTC_AUTO | CTC_RISING | CTC_SCALE16 | CTC_MODETMR
    out	    (PORT_CTC2), a
    ld	    a, 250	    ; 10MHz prescale by 16, divide by 250 is 2.5kHz
    out	    (PORT_CTC2), a
    ; channel 3 is used as a counter on the 2.5kHz signal from channel 2
    ld	    a, CTC_CONTROL | CTC_RESET | CTC_TIMENXT | CTC_RISING | CTC_MODECTR | CTC_INTENA
    out	    (PORT_CTC3), a
    ld	    a, 250	    ; 2.5kHz divided by 250 is 10Hz
    out	    (PORT_CTC3), a
    ret
#endlocal

; CTC channel 3 ISR
ISR_ctc3::
    ex	    af, af'
    exx
    ld	    l, SEG_DP
    call    seg1_toggle
    exx
    ex	    af, af'
    ei
    reti

; void snd_test()
; Bart's Alice 3 boot sound:
; E2, B2, G#3, all 3 channels tone/no noise, all 3 channels on envelope, ~1.3s envelope, rampdown
;     $7B, $01, $FD, $00, $96, $00, $00, $38, $10,$10,$10, $A1,$13, $09, $00,$00
; With IO ports set to output mode, and a test pattern on the outputs:
;     $7B, $01, $FD, $00, $96, $00, $00, $F8, $10,$10,$10, $A1,$13, $09, $A5,$5A
#local
snd_test::
    push    hl
;    ld	    hl, 0xFF00 | SNDREG_ENABLE
;    call    snd_write		; set ports A and B to output mode, disable all channels
;    ld	    hl, 0xA500 | SNDREG_PORTA
;    call    snd_write
;    ld	    hl, 0x5A00 | SNDREG_PORTB
;    call    snd_write
    ld	    hl, boot_sound
    call    snd_writeall
    pop	    hl
    ret
boot_sound:
    .byte $7B, $01, $FD, $00, $96, $00, $00, $F8, $10,$10,$10, $A1,$13, $09, $A5,$5A
#endlocal

; void snd_setaddr(uint8_t address)
; - set the audio chip's internal register address to 'address'
; - assumes audio chip's bus control lines are set IDLE at entry
; TODO: This can probably be carefully open-coded to be more efficient
#local
snd_setaddr::
    push    hl
    M_pio_set_portB_mode PIOMODE_OUTPUT
    ld	    a, l
    out	    (PORT_PIOBDAT), a	; write address to PIO port B
    ld	    l, SNDBUS_ADDR
    call    sysreg_sndbus	; set SYSREG bus control lines to write address (1,1)
    ld	    l, SNDBUS_IDLE
    call    sysreg_sndbus	; set SYSREG bus control lines to idle (0,0)
    pop	    hl
    ret
#endlocal

; void snd_put(uint8_t data)
; - set the audio chip's currently-addressed register to 'data'
; - assumes audio chip's bus control lines are set IDLE at entry
; TODO: This can probably be carefully open-coded to be more efficient
#local
snd_put::
    push    hl
    M_pio_set_portB_mode PIOMODE_OUTPUT
    ld	    a, l
    out	    (PORT_PIOBDAT), a	; write data to PIO port B
    ld	    l, SNDBUS_WRITE
    call    sysreg_sndbus	; set SYSREG bus control lines to write data (1,0)
    ld	    l, SNDBUS_IDLE
    call    sysreg_sndbus	; set SYSREG bus control lines to idle (0,0)
    pop	    hl
    ret
#endlocal

; uint8_t snd_read(uint8_t addr)
; - read value from 'addr' on the sound chip
snd_read::
    call    snd_setaddr
    ; FALLING THROUGH!!!
; uint8_t snd_get()
; - return the contents of the audio chip's currently-addressed register
; - assumes audio chip's bus control lines are set IDLE at entry
; TODO: This can probably be carefully open-coded to be more efficient
#local
snd_get::
    push    bc
    M_pio_set_portB_mode PIOMODE_INPUT
    ld	    l, SNDBUS_READ
    call    sysreg_sndbus	; set SYSREG bus control lines to read data (0,1)
    in	    a, (PORT_PIOBDAT)	; read from PIO port B
    ld	    b, a		; save audio register value in B
    ld	    l, SNDBUS_IDLE
    call    sysreg_sndbus	; set SYSREG bus control lines to idle (0,0)
    ld	    l, b		; return B
    pop	    bc
    ret
#endlocal

; void snd_write(uint8_t addr, uint8_t data)
; - write 'data' to 'addr' on the sound chip
; - 'addr' in L, 'data' in H
#local
snd_write::
    push    hl
    call    snd_setaddr
    ld	    l, h
    call    snd_put
    pop	    hl
    ret
#endlocal

; void snd_writeall(uint8_t *data)
; - write 16 byte values from 'data' to the 16 registers of the sound chip
#local
snd_writeall::
    push    bc
    push    de
    push    hl
    ex	    de, hl		; DE = data
    ld	    l, 0		; L = regnum
    ld	    b, 16		; B = loop count
writeNext:
    ld	    a, (de)		; A = *data
    ld	    h, a
    call    snd_write		; snd_write(regnum, *data)
    inc	    l			; ++regnum
    inc	    de			; ++data
    djnz    writeNext
    pop	    hl
    pop	    de
    pop	    bc
    ret
#endlocal

; void joy_test()
#local
joy_test::
    push    hl
forever:
    in	    a, (PORT_JOY0)	; read joystick 0
    ld	    l, a
    call    joy_map2seg
    call    seg0_write
    in	    a, (PORT_JOY1)	; read joystick 1
    ld	    l, a
    call    joy_map2seg
    call    seg1_write
    jr	    forever
    pop	    hl
    ret
#endlocal

; uint8_t joy_map2seg(uint8_t joy)
; - map the joystick status bits in "joy" to a value suitable for writing to the 7-segment display
; - returns in A
#local
joy_map2seg::
    xor	    a			; start with no bits on 7-segment display
    bit	    JOY_IDX_UP, l	; test for UP
    jr	    nz, done_up
    or	    SEG_A		; turn on top segment
done_up:
    bit	    JOY_IDX_DOWN, l	; test for DOWN
    jr	    nz, done_down
    or	    SEG_D		; turn on bottom segment
done_down:
    ; if neither UP nor DOWN are active, activate (clear) both to get both top & bottom side segments
    bit	    JOY_IDX_UP, l
    jr	    z, sides
    bit	    JOY_IDX_DOWN, l
    jr	    z, sides
    res	    JOY_IDX_UP, l
    res	    JOY_IDX_DOWN, l
sides:
    bit	    JOY_IDX_LEFT, l	; test for LEFT
    jr	    nz, done_left
    bit	    JOY_IDX_UP, l	; if UP, set top-left segment
    jr	    nz, no_top_left
    or	    SEG_F
no_top_left:
    bit	    JOY_IDX_DOWN, l	; if DOWN, set bottom-left segment
    jr	    nz, done_left
    or	    SEG_E
done_left:
    bit	    JOY_IDX_RIGHT, l	; test for RIGHT
    jr	    nz, done_right
    bit	    JOY_IDX_UP, l	; if UP, set top-right segment
    jr	    nz, no_top_right
    or	    SEG_B
no_top_right:
    bit	    JOY_IDX_DOWN, l	; if DOWN, set bottom-right segment
    jr	    nz, done_right
    or	    SEG_C
done_right:
    bit	    JOY_IDX_FIRE, l	; test for FIRE
    ret	    nz
    or	    SEG_DP
    ret
#endlocal

; void seg0_fig8(uint8_t step)
; - advance first 7-segment display to specified figure-8 step (0-7)
#local
seg0_fig8::
    push    hl
    push    bc
    ld	    bc, FIG8_table
    ld	    h, 0
    add	    hl, bc	; hl = FIG8_table + step
    ld	    a, (Seg0_data)
    and	    SEG_DP
    or	    (hl)
    ld	    l, a	; l = (*Seg0_data & SEG_DP) | FIG8_table[step]
    call    seg0_write
    pop	    bc
    pop	    hl
    ret

FIG8_table:
    .byte SEG_A, SEG_B, SEG_G, SEG_E, SEG_D, SEG_C, SEG_G, SEG_F
#endlocal

#include library "libcode"

; Remaining 48KB and 64KB segments to fill up ROM image
#code FILLER1, 0, 0xC000
#code FILLER2, 0, 0x10000

#data RAM, 0x4000, 0xC000
; define static variables here
#include library "libdata"
