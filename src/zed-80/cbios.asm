; ZED-80 CBIOS for CP/M 2.0

#target bin

#include "z80.inc"
#include "z84c20.inc"
#include "z84c30.inc"
#include "z84c40.inc"
#include "ascii.inc"
#include "interrupt.inc"
#include "keyboard.inc"
#include "lcd.inc"
#include "sysreg.inc"
#include "sound.inc"
#include "sdcard.inc"
; Need this for the SD card write protect & present flags.
#include "joystick.inc"
; Need this for debugging (e.g. flashing lights from ISRs)
#include "7segdisp.inc"
#include "cbios.inc"

CPMSECLEN	equ	128	;CP/M has 128-byte sectors
HSTSECLEN	equ	512	;SD card has 512-byte sectors

CDISK		equ	0x0004	;address of current disk number 0=a,... l5=p
IOBYTE		equ	0x0003	;intel i/o byte

; CBIOS is 3.25KB
; We reserve some space at the end for fixed-location data items.
FIXED_DATA_LEN	equ	2
#code CBIOS, CBIOS_BASE, CBIOS_LEN-FIXED_DATA_LEN

; We put SDC_flags and Sysreg at top of RAM so that the ROM monitor can load the correct values
; before starting the CBIOS.
SDC_flags	equ	CBIOS_SDC_flags
; Sysreg is also at a designated address so that it can be shared between CBIOS and any CP/M
; applications that may need to access it.
Sysreg		equ	CBIOS_Sysreg

; Note this means that the cpm22.sys file has to be a multiple of 512 bytes long.
N_BOOT_SECT	equ	($-CCP_BASE)/HSTSECLEN	;warm start sector count

; jump vector for individual subroutines

	jp	boot	;cold start
wboote:	jp	wboot	;warm start
	jp	const	;console status
	jp	conin	;console character in
	jp	conout	;console character out

	ret		;list character from register C
	nop
	nop

	ret		;punch character from register C
	nop
	nop

	;read character into register a from reader device
	ld	a, 0x1a	;return end of file for now
	ret

	jp	home	;move head to home position
	jp	seldsk	;select disk
	jp	settrk	;set track number
	jp	setsec	;set sector number
	jp	setdma	;set dma address
	jp	read	;read disk
	jp	write	;write disk

	xor	a	;return list status (0 if not ready, 1 if ready)
	ret
	nop

	;translate the sector given by BC using the translate table given by DE
	ld	hl, bc		;no translation
	ret			;with value in HL

; Jump table entries below this point are non-standard ZED-80 extensions
	jp	setctcisr   ;set CTC ISR number (0..3) in register C to address in DE
	jp	sndwrite    ;write B bytes from HL to sound chip starting at register number C (ints must be disabled)
	jp	setrawmode  ;set keyboard mode from register C (0:cooked, 1:raw)

;	fixed data tables for one fixed drive
;	no sector translations
N_DISKS		equ	1	;number of disks in the system
#local
DPBASE::
;	disk Parameter header for disk 00
	defw	0000h, 0000h
	defw	0000h, 0000h
	defw	DIRBUF, DSKPARMS
	defw	0000h, all00
;	disk parameter header for disk 01
;	defw	0000h, 0000h
;	defw	0000h, 0000h
;	defw	DIRBUF, DSKPARMS
;	defw	0000h, all01
;	disk parameter header for disk 02
;	defw	0000h, 0000h
;	defw	0000h, 0000h
;	defw	DIRBUF, DSKPARMS
;	defw	0000h, all02
;	disk parameter header for disk 03
;	defw	0000h, 0000h
;	defw	0000h, 0000h
;	defw	DIRBUF, DSKPARMS
;	defw	0000h, all03
;
DSKPARMS: ;disk parameter block for all disks.
	; see: https://original.sharpmz.org/dpb.htm
	; We use:
	;   - 256 sectors per track (128 bytes each)
	;   - 256 tracks per disk
	; This results in an 8MB disk.
	; We use 8KB allocation unit (i.e. block size).
	; All of these parameters must match the settings you specify in
	;    /opt/local/share/diskdefs
	; if you use the cpmtools package (mkfs.cpm) to create a disk image.
	defw	256		;128-byte sectors per track
	defb	6		;block shift factor (8KB allocation unit)
	defb	63		;block mask (16KB allocation unit)
	defb	3		;extent mask
	defw	1023		;(disk size in allocation units)-1
	defw	255		;(num directory entries)-1
	defb	0x80		;alloc 0
	defb	0x00		;alloc 1
	defw	0		;check size 0: media not removable
	defw	1		;track offset
	; BLS = 8KB
	; disk size = 8MB
	; 256 directory entries at 32 bytes each = 8192 bytes, or 1 block
	; so we set AL0=$80, AL1=$00
#endlocal
	; Allocation vectors have size 2 * (DSM/8 + 1)
	; Our disks have DSM=1023, so each vector is 256 bytes long
ALVSIZE equ	256
;	end of fixed tables

welcome_msg:	.text CR, LF, "ZED-80 CBIOS v4 ", __date__, CR, LF
null_msg:	.text NUL

;	individual subroutines to perform each function
boot::	;simplest case is to just perform parameter initialization
	xor	a		;zero in the accum
	ld	(IOBYTE), a	;clear the iobyte
	ld	(CDISK), a	;select disk zero
	ld	de, welcome_msg ;welcome message on cold boot
	jr	bootCommon

wboot::
	ld	de, null_msg	;no message on warm boot
bootCommon:
	ld	sp, 0x80	;use space below buffer for stack

	ld	hl, DATA
	ld	bc, DATA_size
	call    bzero		;zero the DATA segment

	call	lcd_puts	;print welcome message

	ld	hl, 0xFFFF
	ld	(Last_lba), hl
	ld	(Last_lba+2), hl ;clear Last_lba

	call	snd_init	;initialize sound driver
	call	kbdi_init	;initialize keyboard driver
	ld	a, lo(IVT_CTC)  ;all 4 CTC interrupt vectors are consecutive in the IVT
	out	(PORT_CTCIVEC), a ;load CTC Interrupt Vector Register
	M_intr_init		;set up interrupts

	ld 	b, N_BOOT_SECT	;B counts number of sectors to load
	ld	hl, CCP_BASE	;base of CP/M (initial load point)
	ld	de, 0		;start loading at sector 0

loadSector:
	push	hl
	ld	l, '.'
	call	lcd_putc	;write a '.' for each sector load
	pop	hl

	push	bc		;save loop counter
	ld	bc, 0		;clear upper 16 bits of sector number
	call	sdc_read_sector	;read sector number BCDE to SDC_buffer
	pop	bc		;restore loop counter

	or	a		;test A==0
	jr	nz, wboot	;reboot if nonzero

	push	bc		;save loop counter
	ld	bc, HSTSECLEN	;copy HSTSECLEN bytes
	ex	de, hl		;DE=current load address, HL=current sector number
	push	hl		;save current sector number
	ld	hl, SDC_buffer	;HL=SDC_buffer
	ldir			;copy from *HL to *DE for BC bytes
	pop	hl		;restore current sector number
	pop	bc		;restore loop counter
	ex	de, hl		;HL=next load address, DE=current sector number
	inc	de		;advance sector counter
	djnz	loadSector

	ld 	c, 0		;select disk 0
	call	seldsk
	call	home		;go to track 00

	ld 	a, 0xc3		;c3 is a jmp instruction
	ld	(0), a		;for jmp to wboot
	ld	hl, wboote	;wboot entry point
	ld	(1), hl		;set address field for jmp at 0

	ld	(5), a		;for jmp to bdos
	ld	hl, BDOS_BASE	;bdos entry point
	ld	(6), hl		;address field of Jump at 5 to bdos

	ld	bc, 0x80	;default dma address is 80h
	call	setdma

	ld	a, (CDISK)	;get current disk number
	ld	c, a		;save it in C
	and	0xF		;clear out user # (high nibble)
	cp	N_DISKS		;see if valid disk number
	jr	c, diskok	;disk valid, go to ccp
	ld	c, 0		;invalid disk, change to disk 0, user 0
diskok:	jp	CCP_BASE	;(user,disk) in C, jump to cp/m for further processing
;
#local
const::	;console status, return (in A) 0xFF if character ready, 0x00 if not
	call	kbdi_chkinp	;check if the keyboard driver has a char waiting
	jr	z, return00	;return 0x00 if keyboard is idle
	ld	a, 0xff		;return 0xFF means a character is ready
	ret
return00:
	xor	a		;return 0x00 means no character ready
	ret
#endlocal
;
#local
conin::	;console character into register A
	call	kbdi_getc	;block until keyboard input is ready
	ld	a, l		;return input char in A
	ret
#endlocal
;
conout::;console character output from register c
	ld	l, c
	jp	lcd_putc
;
;	i/o drivers for the disk follow
;	for now, we will simply store the parameters away for use
;	in the read and write subroutines
;
seldsk::;select disk given by register c
	ld	hl, 0		;return 0 on error, and we use H=0 later
	ld 	a, c
	cp	N_DISKS		;must be between 0 and N_DISKS-1
	ret	nc		;no carry if >= N_DISKS
	ld	(Diskno), a
	; TODO: if disk is being changed, clear Last_lba
;	disk number is in the proper range
;	compute proper disk parameter header address
	;FALLING THROUGH!
getdph:	;return current disk's (Diskno) DPH address in HL
	;destroys: DE
	ld 	hl, (Diskno)	;l=Diskno, h=junk
	ld	h, 0		;hl=Diskno
	add	hl, hl		;*2
	add	hl, hl		;*4
	add	hl, hl		;*8
	add	hl, hl		;*16 (size of each header)
	ld	de, DPBASE
	add	hl, de		;hl=DPBASE+(Diskno*16)
	ret

getdpb: ;return current disk's (Diskno) DPB address in DE
	;destroys: HL
	call	getdph		;hl=disk parameter header
	ld	de, 10
	add	hl, de		;hl=dph+10
	ld	e, (hl)
	inc	hl
	ld	d, (hl)		;de=*hl
	ret

getspt:	;return current disk's (Diskno) SPT in DE
	;destroys: HL
	call	getdpb		;de=disk parameter block
	ex	de, hl		;hl=disk parameter block
	ld	e, (hl)
	inc	hl
	ld	d, (hl)		;de=*hl
	ret
;
home::	;move to the track 00 position of current drive
	;translate this call into a settrk call with parameter 00
	ld	bc, 0		;select track 0
	; FALLING THROUGH!
settrk::;set track given by register bc
	ld	(Track), bc
	ret
;
setsec::;set sector given by register bc
	ld	(Sector), bc
	ret
;
setdma::;set dma address given by registers b and c
	ld	(Dmaad), bc
	ret

getlinsec:: ;return linear (128-byte) sector number for current I/O operation in DEHL
	call	getspt		;DE=sectors per track
	ld	bc, (Track)	;BC=track number
	call	mul16		;DEHL=spt * track
	ld	bc, (Sector) 	;BC=sector number
	add	hl, bc		;HL += BC, carry flag set as needed
	ret	nc
	inc	de
	ret

; uint32_t (DEHL) trancpm2hst(uint32_t (DEHL) cpmsec)
; - translate linear CP/M sector number in 'cpmsec' to host sector number (div by 4)
; - return subsector offset in A (0-3)
; - destroys: B
#local
trancpm2hst::
	ld	a, l
	and	0x03		;a = l & 0x03
	ld	b, 2		;loop count = 2
loop:
	srl	d		;d >>= 1, shift out into carry flag
	rr	e		;e = (carry << 7) | (e >> 1), shift out into carry flag
	rr	h		;h = (carry << 7) | (h >> 1), shift out into carry flag
	rr	l		;l = (carry << 7) | (l >> 1), shift out into carry flag
	djnz	loop		;do it twice
	ret
#endlocal

; uint8_t (A) cached_read_sector(uint32_t (BCDE) host_sector)
; - verify that Last_lba == host_sector, or if not, read host_sector into SDC_buffer
;   and set Last_lba = host_sector
; - return 0 in A if the operation completes successfully, and 1 if an error occurs
#local
cached_read_sector::
	push	hl
	ld	hl, (Last_lba)	;HL = low word of Last_lba
	xor	a		;A = 0, clear carry flag
	sbc	hl, de		;compare low words of Last_lba and host_sector
	jr	nz, do_read	;mismatch => must read the sector
	ld	hl, (Last_lba+2) ;HL = high word of Last_lba
	sbc	hl, bc		;compare high words of Last_lba and host_sector
	jr	nz, do_read	;mismatch => must read the sector
	pop	hl
	ret			;cached read => return 0
do_read:
	pop	hl
	ld	(Last_lba), de
	ld	(Last_lba+2), bc ;Last_lba = host_sector
	jp	sdc_read_sector	;read sector number BCDE to SDC_buffer
#endlocal

;Read one CP/M sector from disk.
;Return a 00h in register a if the operation completes properly,
;and nonzero if an error occurs during the read.
;Disk number in 'Diskno'
;Track number in 'Track'
;Sector number in 'Sector'
;Dma address in 'Dmaad' ($0000-$FFFF)
#local
read::
	call	getlinsec	;DEHL = linear sector number (128-byte sectors)
	call	trancpm2hst	;DEHL = host sector number, A = subsector offset
	ex	de, hl		;HLDE = host sector number
	ld	bc, hl		;BCDE = host sector number
	ld	l, a		;save subsector offset in L
	call	cached_read_sector ;read sector number BCDE to SDC_buffer
	or	a		;test A==0
	ret	nz		;return failure (i.e. nonzero) if nonzero
	ld	a, l		;restore subsector offset to A
	ld	bc, CPMSECLEN	;BC=128
	ld	hl, SDC_buffer	;copy from &SDC_buffer[offset*128]
	bit	0, a		;test A & 0x01
	jr	z, skip1
	add	hl, bc		;HL += 128
skip1:
	and	0x02		;test A & 0x02
	jr	z, skip2
	inc	h		;HL += 256
skip2:
	ld	de, (Dmaad)	;copy to Dmaad
	ldir			;copy from *HL to *DE for BC bytes
	xor	a		;return 0 for success
	ret
#endlocal

;Write one CP/M sector to disk.
;Return a 00h in register a if the operation completes properly,
;and nonzero if an error occurs during the read or write
;Disk number in 'Diskno'
;Track number in 'Track'
;Sector number in 'Sector'
;Dma address in 'Dmaad' ($0000-$FFFF)
#local
write::
	; read host sector, copy in new CP/M sub-sector, write host sector
	call	getlinsec	;DEHL = linear sector number (128-byte sectors)
	call	trancpm2hst	;DEHL = host sector number, A = subsector offset
	ex	de, hl		;HLDE = host sector number
	ld	bc, hl		;BCDE = host sector number
	ld	l, a		;save subsector offset in L
	call	cached_read_sector ;read sector number BCDE to SDC_buffer
	or	a		;test A==0
	ret	nz		;return failure (i.e. nonzero) if nonzero

	push	bc
	push	de		;save host sector number
	ld	a, l		;restore subsector offset to A
	ld	bc, CPMSECLEN	;BC=128
	ld	hl, SDC_buffer	;copy to &SDC_buffer[offset*128]
	bit	0, a		;test A & 0x01
	jr	z, skip1
	add	hl, bc		;HL += 128
skip1:
	and	0x02		;test A & 0x02
	jr	z, skip2
	inc	h		;HL += 256
skip2:
	ex	de, hl		;DE = &SDC_buffer[offset*128]
	ld	hl, (Dmaad)	;copy from Dmaad
	ldir			;copy from *HL to *DE for BC bytes
	pop	de
	pop	bc		;restore host sector number
	jp	sdc_write_sector ;write sector number BCDE from SDC_buffer
#endlocal

;set CTC ISR slot (0..3) in register C to address in DE
setctcisr::
	ld	a, lo(IVT_CTC)	;calculate low byte of ISR slot address
	add	c
	add	c		;IVT_CTC is 8-byte aligned, so this can't overflow
	ld	h, hi(IVT_CTC)
	ld	l, a		;HL = ISR slot address
	di			;disable interrupts
	ld	(hl), e
	inc	hl
	ld	(hl), d		;write ISR from DE into ISR slot
	ei			;enable interrupts
	ret

;write B bytes from HL to sound chip starting at register number C (ints must be disabled)
#local
sndwrite::
	ld	d, c		;D = regnum
loop:
	ld	a, (hl)		;A = *data
	ld	e, a
	call    snd_write	;snd_write(regnum, *data)
	inc	d		;++regnum
	inc	hl		;++data
	djnz    loop		;loop while --B > 0
	ret
#endlocal

;set keyboard input mode from register C (0:cooked, 1:raw)
#local
setrawmode::
	ld	hl, Kbd_modifiers ;HL = &Kbd_modifiers
	bit	KMOD_RAW_BIT, c	;test KMOD_RAW_BIT of C
	jr	z, cooked	;RAW bit off => set cooked mode
	set	KMOD_RAW_BIT, (hl) ;Kbd_modifiers |= (1 << KMOD_RAW_BIT)
	ret
cooked:
	res	KMOD_RAW_BIT, (hl) ;Kbd_modifiers &= ~(1 << KMOD_RAW_BIT)
	ret
#endlocal


; Interrupt Vector Table: must be word-aligned, since peripheral IV registers force bit 0 = 0
;
; Note, it also must not cross a 256-byte boundary, since the upper byte of the IVT is stored
; in the CPU's I register and is global to all interrupt sources. We use 16-byte alignment to
; ensure there is no crossing.
    .align  16
IVT::
; CTC's IVT has 4 slots, and we put it first since it needs to be 8-byte aligned.
IVT_CTC::
    .word   ISR_nop	    ; CTC channel 0
    .word   ISR_nop	    ; CTC channel 1
    .word   ISR_nop	    ; CTC channel 2
    .word   ISR_nop	    ; CTC channel 3
; PIO has separate IV registers for ports A and B, and we only use A
IVT_PIOA::
    .word   ISR_pioA	    ; PIO port A

#include library "libcode"

;
; CBIOS data area
;
Track:	defw	0		;last track set via SETTRK
Sector:	defw	0		;last sector set via SETSEC
Dmaad:	defw	0		;direct memory address set via SETDMA
Diskno:	defb	0		;disk number 0-15 set via SELDSK
Last_lba: .long $FFFFFFFF	;last LBA read/written through SDC_buffer

; Everything from here for DATA_size bytes gets zeroed at startup
DATA	    equ $
;	scratch ram area for bdos use
DIRBUF:	defs	128	 	;scratch directory area
all00:	defs	ALVSIZE	 	;allocation vector 0

; static data used by library routines
#include library "libdata"

DATA_size   equ $ - DATA	;size of DATA area to zero at startup

#code CBIOS_FIXDATA, *, FIXED_DATA_LEN
; filled with zeroes, this is where fixed-location data items like SDC_flags and Sysreg reside
