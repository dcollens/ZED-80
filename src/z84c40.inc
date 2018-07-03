; The Z84C40 is the Z80's SIO peripheral. See um0081.pdf for documentation.

PORT_SIOBASE	    equ 0x20		    ; base port address for SIO chip
PORT_SIOADAT	    equ PORT_SIOBASE	    ; port address for SIO port A, data register
PORT_SIOBDAT	    equ PORT_SIOBASE + 1    ; port address for SIO port B, data register
PORT_SIOACTL	    equ PORT_SIOBASE + 2    ; port address for SIO port A, control register
PORT_SIOBCTL	    equ PORT_SIOBASE + 3    ; port address for SIO port B, control register

; WR0 "CRC Reset Code" values (bits 7-6)
SIOWR0_CRC_NOP		equ 0x00	    ; no CRC reset code
SIOWR0_CRC_RST_RX_CHK	equ 1 << 6	    ; reset RX CRC checker
SIOWR0_CRC_RST_TX_GEN	equ 2 << 6	    ; reset TX CRC generator
SIOWR0_CRC_RST_TX_UNDR  equ 3 << 6	    ; reset TX underrun/EOM latch

; WR0 "Command" values (bits 5-3)
SIOWR0_CMD_NOP		equ 0x00	    ; no command
SIOWR0_CMD_SND_ABRT	equ 1 << 3	    ; send abort (SDLC only)
SIOWR0_CMD_RST_EXTINT	equ 2 << 3	    ; reset external/status interrupts
SIOWR0_CMD_RST_CHAN	equ 3 << 3	    ; reset channel
SIOWR0_CMD_INTENA_NXTRX	equ 4 << 3	    ; enable interrupt on next receive character
SIOWR0_CMD_RST_TXINTPND equ 5 << 3	    ; reset TX interrupt pending
SIOWR0_CMD_RST_ERR	equ 6 << 3	    ; reset error latches
SIOWR0_CMD_INTRETN	equ 7 << 3	    ; return from interrupt (not needed with Z80)

; WR0 "Pointer" values (bits 2-0)
SIOWR0_PTR_R0		equ 0x00	    ; set pointer to register 0
SIOWR0_PTR_R1		equ 0x01	    ; set pointer to register 1
SIOWR0_PTR_R2		equ 0x02	    ; set pointer to register 2
SIOWR0_PTR_R3		equ 0x03	    ; set pointer to register 3
SIOWR0_PTR_R4		equ 0x04	    ; set pointer to register 4
SIOWR0_PTR_R5		equ 0x05	    ; set pointer to register 5
SIOWR0_PTR_R6		equ 0x06	    ; set pointer to register 6
SIOWR0_PTR_R7		equ 0x07	    ; set pointer to register 7

; WR1 interrupt & wait/ready control bits
SIOWR1_EXTINTENA	equ 0x01	    ; external/status interrupt enable
SIOWR1_TXINTENA		equ 0x02	    ; TX interrupt enable
SIOWR1_STATIVEC		equ 0x04	    ; status affects interrupt vector (set in ch. B only)
SIOWR1_RXINT_DISABLE	equ 0 << 3	    ; RX interrupts disabled
SIOWR1_RXINT_FIRST	equ 1 << 3	    ; RX interrupt on first character
SIOWR1_RXINT_ALLPRTY	equ 2 << 3	    ; RX interrupt on all characters, parity err is SR cond
SIOWR1_RXINT_ALLNPRTY	equ 3 << 3	    ; RX interrupt on all characters, parity err no intr
; bits 7-5 are for WAIT/READY functions, which we don't use (always write as 0)

; WR2 is the interrupt vector register (set in channel B only)

; WR3 receiver logic control bits
SIOWR3_RXENA		equ 0x01	    ; receiver enable
SIOWR3_SYNC_INHIBIT	equ 0x02	    ; sync character load inhibit
SIOWR3_ADDR_SRCHMODE	equ 0x04	    ; address search mode
SIOWR3_RXCRCENA		equ 0x08	    ; receiver CRC enable
SIOWR3_ENTER_HUNT	equ 0x10	    ; enter hunt phase
SIOWR3_AUTO_ENABLES	equ 0x20	    ; auto enables (DCD/CTS are RX/TX enables)
SIOWR3_RX_5_BITS	equ 0 << 6	    ; receive 5 bits/character
SIOWR3_RX_7_BITS	equ 1 << 6	    ; receive 7 bits/character
SIOWR3_RX_6_BITS	equ 2 << 6	    ; receive 6 bits/character
SIOWR3_RX_8_BITS	equ 3 << 6	    ; receive 8 bits/character

; WR4 RX/TX configuration (set first before WR1, WR3, WR5, WR6, and WR7)
SIOWR4_PARITY		equ 0x01	    ; parity on/off
SIOWR4_PRTY_EVEN	equ 0x02	    ; even parity
SIOWR4_PRTY_ODD		equ 0x00	    ; odd parity
SIOWR4_TXSTOP_SYNC	equ 0 << 2	    ; synchronous mode (no TX stop bits)
SIOWR4_TXSTOP_1		equ 1 << 2	    ; 1 TX stop bit
SIOWR4_TXSTOP_1_5	equ 2 << 2	    ; 1.5 TX stop bits
SIOWR4_TXSTOP_2		equ 3 << 2	    ; 2 TX stop bits
; bits 5-4 set the sync modes, which we don't use (always write as 0)
SIOWR4_CLK_x1		equ 0 << 6	    ; data rate x1 = clock rate
SIOWR4_CLK_x16		equ 1 << 6	    ; data rate x16 = clock rate
SIOWR4_CLK_x32		equ 2 << 6	    ; data rate x32 = clock rate
SIOWR4_CLK_x64		equ 3 << 6	    ; data rate x64 = clock rate

; WR5 transmitter logic control bits
SIOWR5_TXCRCENA		equ 0x01	    ; transmitter CRC enable
SIOWR5_RTS		equ 0x02	    ; request to send
SIOWR5_CRC16_SDLC	equ 0x04	    ; CRC-16 vs. SDLC polynomial
SIOWR5_TXENA		equ 0x08	    ; transmitter enable
SIOWR5_SND_BRK		equ 0x10	    ; send break
SIOWR5_TX_5_BITS	equ 0 << 5	    ; transmit 5 bits/character
SIOWR5_TX_7_BITS	equ 1 << 5	    ; transmit 7 bits/character
SIOWR5_TX_6_BITS	equ 2 << 5	    ; transmit 6 bits/character
SIOWR5_TX_8_BITS	equ 3 << 5	    ; transmit 8 bits/character
SIOWR5_DTR		equ 0x80	    ; data terminal ready

; WR6 transmitter sync register for use in synchronous modes, which we don't use
; WR7 receiver sync register for use in synchronous modes, which we don't use

; RR0 status bits (mostly normal operation)
SIORR0_RCA		equ 0x01	    ; RX character available
SIORR0_INTPND		equ 0x02	    ; interrupt pending (channel A only)
SIORR0_TBE		equ 0x04	    ; TX buffer empty
SIORR0_DCD		equ 0x08	    ; latched DCD input bit
SIORR0_SYNC		equ 0x10	    ; latched SYNC input bit (hunt in SDLC)
SIORR0_CTS		equ 0x20	    ; latched CTS input bit
SIORR0_TX_UNDR		equ 0x40	    ; TX underrun / end of message
SIORR0_BRK_ABRT		equ 0x80	    ; break/abort detected
; As bit numbers, useful for the "bit" instruction, to test individual bit flags
SIORR0_IDX_RCA		equ 0
SIORR0_IDX_INTPND	equ 1
SIORR0_IDX_TBE		equ 2
SIORR0_IDX_DCD		equ 3
SIORR0_IDX_SYNC		equ 4
SIORR0_IDX_CTS		equ 5
SIORR0_IDX_TX_UNDR	equ 6
SIORR0_IDX_BRK_ABRT	equ 7

; RR1 status bits (mostly errors)
SIORR1_ALLSENT		equ 0x01	    ; all characters fully sent
; bits 3-1 are SDLC-only
SIORR1_PRTYERR		equ 0x10	    ; parity error
SIORR1_ROE		equ 0x20	    ; RX overrun error
SIORR1_CRCFRMERR	equ 0x40	    ; CRC/framing error
; bit 7 is SDLC-only

; RR2 is the interrupt vector register (read from channel B only)
; - if "Status Affects Vector" bit is set, this will be the current vector value,
;   modified by whatever interrupt conditions are pending

M_sio_reset	macro
    ld	    a, SIOWR0_CMD_RST_CHAN
    out	    (PORT_SIOACTL), a
    out	    (PORT_SIOBCTL), a
    endm
