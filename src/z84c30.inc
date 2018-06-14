; The Z84C30 is the Z80's CTC peripheral. See um0081.pdf for documentation.

PORT_CTCBASE	equ 0x40		; base port address for CTC chip
PORT_CTCIVEC	equ PORT_CTCBASE	; port address for Interrupt Vector Register
PORT_CTC0	equ PORT_CTCBASE	; port address for CTC channel 0
PORT_CTC1	equ PORT_CTCBASE + 1	; port address for CTC channel 1
PORT_CTC2	equ PORT_CTCBASE + 2	; port address for CTC channel 2
PORT_CTC3	equ PORT_CTCBASE + 3	; port address for CTC channel 3

; CTC Channel Control Word bits
CTC_INTENA	equ 0x80		; enable interrupts
CTC_INTDIS	equ 0x00		; disable interrupts
CTC_MODECTR	equ 0x40		; COUNTER mode
CTC_MODETMR	equ 0x00		; TIMER mode
CTC_SCALE256	equ 0x20		; prescale by 256
CTC_SCALE16	equ 0x00		; prescale by 16
CTC_RISING	equ 0x10		; CLK/TRG on rising edges
CTC_FALLING	equ 0x00		; CLK/TRG on falling edges
CTC_CLKTRG	equ 0x08		; CLK/TRG pulse starts timer
CTC_AUTO	equ 0x00		; automatic timer start after loading time constant
CTC_TIMENXT	equ 0x04		; next control byte written is the time constant
CTC_RESET	equ 0x02		; software reset
CTC_CONTROL	equ 0x01		; always set to indicate this is a control word, not IVEC 
