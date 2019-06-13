; Calling convention used in this program
; ---------------------------------------
;
; Unless otherwise noted, the first parameter, and the return value are stored as follows:
; 8 bits: L
; 16 bits: HL
; 32 bits: DEHL
;
; Additional parameters are passed on the stack, left-to-right.
; Parameters and return values larger than 32 bits are passed on the stack (return value
; space set up by caller as a hidden first argument).
; Callee saves/restores any modified registers.
; Caller pops arguments after call returns.
; AF registers are scratch (caller preserves, if needed).

; same as 'rom', except that the default fill byte for 'defs' etc. is 0x00
#target bin

#include "z80.inc"
#include "7segdisp.inc"
#include "z84c20.inc"
#include "z84c30.inc"
#include "z84c40.inc"
#include "ascii.inc"
#include "sound.inc"

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; our code will load immediately above the ROM
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
#code TEXT,0x4000

; Careful, don't put anything before "init", as this is the entry point to our code.
#local
init::
    ; zero the DATA segment
    ld	    hl, DATA
    ld	    bc, DATA_size
    call    bzero

    ; Set Sysreg to the value that we know the ROM monitor set it to.
    ld	    a, SYS_MMUEN | SYS_SDCS | SYS_SDICLR
    ld	    (Sysreg), a

    call    seg_init		    ; clear 7-segment display

    ; play a song on the audio chip
playSong:
    ld	    hl, song_data
    ld      de, 16
    ld      bc, Audio_frame_count

nextFrame:
    call    snd_writeall
    add     hl, de
    push    hl
    ld      l, 20
    call    delay_ms
    pop     hl
    dec     bc
    ld      a, b
    or      c
    jp      nz, nextFrame

    jr	    playSong

song_data:
#include "../ym2asm/axelf.asm"
#endlocal

#include library "libcode"

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; data segment immediately follows code
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

#data DATA,TEXT_end
; define static variables here

#include library "libdata"
