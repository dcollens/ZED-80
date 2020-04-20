; Bus control states
SNDBUS_IDLE	    equ 0
SNDBUS_READ	    equ SYS_BC1
SNDBUS_WRITE	    equ SYS_BDIR
SNDBUS_ADDR	    equ SYS_BDIR | SYS_BC1

; Register names and numbers
SNDREG_ATPF	    equ 0		; channel A tone period, fine
SNDREG_ATPC	    equ 1		; channel A tone period, coarse
SNDREG_BTPF	    equ 2		; channel B tone period, fine
SNDREG_BTPC	    equ 3		; channel B tone period, coarse
SNDREG_CTPF	    equ 4		; channel C tone period, fine
SNDREG_CTPC	    equ 5		; channel C tone period, coarse
SNDREG_NOISE	    equ 6		; noise period
SNDREG_ENABLE	    equ 7		; enables and IO directions
SNDREG_AAMP	    equ 8		; channel A amplitude
SNDREG_BAMP	    equ 9		; channel B amplitude
SNDREG_CAMP	    equ 10		; channel C amplitude
SNDREG_ENVF	    equ 11		; envelope period, fine
SNDREG_ENVC	    equ 12		; envelope period, coarse
SNDREG_ENVS	    equ 13		; envelope shape & cycle
SNDREG_PORTA	    equ 14		; IO port A data
SNDREG_PORTB	    equ 15		; IO port B data

; SNDREG_ENABLE fields
SNDENA_ATONE	    equ 0x01		; ~ channel A tone enable
SNDENA_BTONE	    equ 0x02		; ~ channel B tone enable
SNDENA_CTONE	    equ 0x04		; ~ channel C tone enable
SNDENA_ANOISE	    equ	0x08		; ~ channel A noise enable
SNDENA_BNOISE	    equ 0x10		; ~ channel B noise enable
SNDENA_CNOISE	    equ 0x20		; ~ channel C noise enable
SNDENA_AIODIR	    equ 0x40		; IO port A direction (0=in, 1=out)
SNDENA_BIODIR	    equ 0x80		; IO port B direction (0=in, 1=out)
