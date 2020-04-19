; Constants for the size and layout of the CCP, BDOS, and CBIOS for CP/M 2.2

;
; Set memory limit here. This is the amount of contigeous
; RAM starting from 0x0000. CP/M will reside at the end of this space.
;
MEM_SIZE    equ	64*1024		; a 64k system

CBIOS_LEN   equ	0x0D00		; length of CBIOS, 3.25KB now
CBIOS_BASE  equ	MEM_SIZE-CBIOS_LEN ; base address of CBIOS

; Fixed-location data items so ROM monitor can stuff values in at boot time.
CBIOS_SDC_flags equ CBIOS_BASE+CBIOS_LEN-1
CBIOS_Sysreg	equ CBIOS_BASE+CBIOS_LEN-2

CPM22_SYS_LEN equ 0x1600	; length of CPM22.SYS, 5.5KB now
CPM22_SYS_BASE equ CBIOS_BASE-CPM22_SYS_LEN ; base address of CPM22.SYS

CCP_BASE    equ	CPM22_SYS_BASE	; base address of CCP
BDOS_BASE   equ	CCP_BASE+0x0806	; BDOS entry point
