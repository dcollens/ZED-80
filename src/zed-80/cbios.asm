; ZED-80 CBIOS for CP/M 2.0

#target bin

#include "z80.inc"
#include "z84c20.inc"
#include "ascii.inc"
#include "keyboard.inc"
#include "lcd.inc"
#include "sysreg.inc"
#include "sdcard.inc"

CPMSECLEN	equ	128	;CP/M has 128-byte sectors
HSTSECLEN	equ	512	;SD card has 512-byte sectors

CCP_BASE	equ	0xE000	;base of ccp
BDOS_BASE	equ	0xE806	;bdos entry
BIOS_BASE	equ	0xF600	;base of bios
CDISK		equ	0x0004	;address of current disk number 0=a,... l5=p
IOBYTE		equ	0x0003	;intel i/o byte

; CBIOS is 2.5KB
#code CBIOS, BIOS_BASE, 0xA00

N_BOOT_SECT	equ	($-CCP_BASE)/CPMSECLEN	;warm start sector count

; jump vector for individual subroutines

	jp	boot	;cold start
wboote:	jp	wboot	;warm start
	jp	const	;console status
	jp	conin	;console character in
	jp	conout	;console character out

	ret		;list character from register c
	nop
	nop

	ret		;punch character from register c
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

	;translate the sector given by bc using the translate table given by de
	ld	hl, bc		;no translation
	ret			;with value in hl

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
	; Sector and track numbers must fit in 8 bits, so we use:
	;   - 256 sectors per track (128 bytes each)
	;   - 256 tracks per disk
	; This results in an 8MB disk.
	; We use 8KB allocation unit (i.e. block size).
	;
	; NOTE: we cheat in the read/write routines and assume sectors per track is 256 rather
	; than consult the disk parameter block.
	defw	256		;128-byte sectors per track
	defb	6		;block shift factor (8KB allocation unit)
	defb	63		;block mask (16KB allocation unit)
	defb	3		;extent mask
	defw	1023		;(disk size in allocation units)-1
	defw	255		;(num directory entries)-1
	defb	0x80		;alloc 0
	defb	0x00		;alloc 1
	defw	0		;check size 0: media not removable
	defw	0		;track offset
	; BLS = 8KB
	; disk size = 8MB
	; 256 directory entries at 32 bytes each = 8192 bytes, or 1 block
	; so we set AL0=$80, AL1=$00
#endlocal
	; Allocation vectors have size 2 * (DSM/8 + 1)
	; Our disks have DSM=1023, so each vector is 256 bytes long
ALVSIZE equ	256
;	end of fixed tables

;	individual subroutines to perform each function
boot::	;simplest case is to just perform parameter initialization
	xor	a		;zero in the accum
	ld	(IOBYTE), a	;clear the iobyte
	ld	(CDISK), a	;select disk zero
	jr	gocpm		;initialize and go to cp/m
;
wboot::	;simplest case is to read the disk until all sectors loaded
	ld	sp, 0x80	;use space below buffer for stack
	ld 	c, 0		;select disk 0
	call	seldsk
	call	home		;go to track 00
;
	ld 	b, N_BOOT_SECT	;b counts number of sectors to load
	ld 	c, 0		;c has the current track number
	ld 	d, 2		;d has the next sector to read
;	note that we begin by reading track 0, sector 2 since sector 1
;	contains the cold start loader, which is skipped in a warm start
	ld	hl, CCP_BASE	;base of cp/m (initial load point)
load1:	;load	one more sector
	push	bc		;save sector count, current track
	push	de		;save next sector to read
	push	hl		;save dma address
	ld 	c, d		;get sector address to register C
	call	setsec		;set sector address from register C
	pop	bc		;recall dma address to b, C
	push	bc		;replace on stack for later recall
	call	setdma		;set dma address from b, C
;
;	drive set to 0, track set, sector set, dma address set
	call	read
	cp	0		;any errors?
	jr	nz, wboot	;retry the entire boot if an error occurs
;
;	no error, move to next sector
	pop	hl		;recall dma address
	ld	de, CPMSECLEN	;dma=dma+128
	add	hl, de		;new dma address is in h, l
	pop	de		;recall sector address
	pop	bc		;recall number of sectors remaining, and current trk
	dec	b		;sectors=sectors-1
	jr	z, gocpm	;transfer to cp/m if all have been loaded
;
;	more	sectors remain to load, check for track change
	inc	d
	ld 	a, d		;sector=27?, if so, change tracks
	cp	27
	jr	c, load1	;carry generated if sector<27
;
;	end of	current track,	go to next track
	ld 	d, 1		;begin with first sector of next track
	inc	c		;track=track+1
;
;	save	register state, and change tracks
	push	bc
	push	de
	push	hl
	call	settrk		;track address set from register c
	pop	hl
	pop	de
	pop	bc
	jr	load1		;for another sector
;
;	end of	load operation, set parameters and go to cp/m
gocpm:
	ld 	a, 0xc3		;c3 is a jmp instruction
	ld	(0), a		;for jmp to wboot
	ld	hl, wboote	;wboot entry point
	ld	(1), hl		;set address field for jmp at 0
;
	ld	(5), a		;for jmp to bdos
	ld	hl, BDOS_BASE	;bdos entry point
	ld	(6), hl		;address field of Jump at 5 to bdos
;
	ld	bc, 0x80	;default dma address is 80h
	call	setdma
;
;	ei			;enable the interrupt system
	ld	a, (CDISK)	;get current disk number
	cp	N_DISKS		;see if valid disk number
	jr	c, diskok	;disk valid, go to ccp
	xor	a		;invalid disk, change to disk 0
diskok:	ld 	c, a		;send to the ccp
	jp	CCP_BASE	;go to cp/m for further processing
;
;
;	simple i/o handlers (must be filled in by user)
;	in each case, the entry point is provided, with space reserved
;	to insert your own code
;
#local
const::	;console status, return 0ffh if character ready, 00h if not
	call	kbd_poll	;check keyboard for a character
	jr	z, return0	;no character available?
	ld	a, 0xff		;char ready	
	ret
return0:
	xor	a		;no char
	ret
#endlocal
;
conin::	;console character into register a
	call	kbd_getc
	ld	a, l
	ret
;
conout::;console character output from register c
	ld	l, c
	call	lcd_putc
	ret
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
	ld	(diskno), a
;	disk number is in the proper range
;	compute proper disk parameter header address
	;FALLING THROUGH!
getdph:	;return current disk's (diskno) DPH address in HL
	;destroys: DE
	ld 	hl, (diskno)	;l=diskno, h=junk
	ld	h, 0		;hl=diskno
	add	hl, hl		;*2
	add	hl, hl		;*4
	add	hl, hl		;*8
	add	hl, hl		;*16 (size of each header)
	ld	de, DPBASE
	add	hl, de		;hl=DPBASE+(diskno*16)
	ret

getdpb: ;return current disk's (diskno) DPB address in DE
	;destroys: HL
	call	getdph		;hl=disk parameter header
	ld	de, 10
	add	hl, de		;hl=dph+10
	ld	e, (hl)
	inc	hl
	ld	d, (hl)		;de=*hl
	ret

getspt:	;return current disk's (diskno) SPT in DE
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
	ld	(track), bc
	ret
;
setsec::;set sector given by register bc
	ld	(sector), bc
	ret
;
setdma::;set dma address given by registers b and c
	ld	(dmaad), bc
	ret

getlinsec:: ;return linear (128-byte) sector number for current I/O operation in DEHL
	call	getspt		;DE=sectors per track
	ld	bc, (track)	;BC=track number
	call	mul16		;DEHL=spt * track
	ld	bc, (sector) 	;BC=sector number
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

#local
read::
;Read one CP/M sector from disk.
;Return a 00h in register a if the operation completes properly,
;and 01h if an error occurs during the read.
;Disk number in 'diskno'
;Track number in 'track'
;Sector number in 'sector'
;Dma address in 'dmaad' ($0000-$FFFF)
;
	call	getlinsec	;DEHL = linear sector number (128-byte sectors)
	call	trancpm2hst	;DEHL = host sector number, A = subsector offset
	ex	de, hl		;HLDE = host sector number
	ld	bc, hl		;BCDE = host sector number
	ld	l, a		;save subsector offset in L
	call	sdc_read_sector	;read sector number BCDE to SDC_buffer
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
	ld	de, (dmaad)	;copy to dmaad
	ldir			;copy from *HL to *DE for BC bytes
	xor	a		;return 0 for success
	ret
#endlocal

write:
;Write one CP/M sector to disk.
;Return a 00h in register a if the operation completes properly,
;and 01h if an error occurs during the read or write
;Disk number in 'diskno'
;Track number in 'track'
;Sector number in 'sector'
;Dma address in 'dmaad' ($0000-$FFFF)
;
	ld	a, 1		;fail
	ret

#include library "libcode"

;
;	the remainder of the cbios is reserved uninitialized
;	data area, and does not need to be a part of the
;	system memory image (the space must be available,
;	however).
;
track:	defs	2		;last track set via SETTRK
sector:	defs	2		;last sector set via SETSEC
dmaad:	defs	2		;direct memory address set via SETDMA
diskno:	defs	1		;disk number 0-15 set via SELDSK
;
;	scratch ram area for bdos use
DIRBUF:	defs	128	 	;scratch directory area
all00:	defs	ALVSIZE	 	;allocation vector 0

; static data used by library routines
#include library "libdata"
