#ifndef _CTC_H_INCLUDED
#define _CTC_H_INCLUDED

// CTC Channel Control Word bits
#define CTC_INTENA	0x80		// enable interrupts
#define CTC_INTDIS	0x00		// disable interrupts
#define CTC_MODECTR	0x40		// COUNTER mode
#define CTC_MODETMR	0x00		// TIMER mode
#define CTC_SCALE256	0x20		// prescale by 256
#define CTC_SCALE16	0x00		// prescale by 16
#define CTC_RISING	0x10		// CLK/TRG on rising edges
#define CTC_FALLING	0x00		// CLK/TRG on falling edges
#define CTC_CLKTRG	0x08		// CLK/TRG pulse starts timer
#define CTC_AUTO	0x00		// automatic timer start after loading time constant
#define CTC_TIMENXT	0x04		// next control byte written is the time constant
#define CTC_RESET	0x02		// software reset
#define CTC_CONTROL	0x01		// always set to indicate this is a control word, not IVEC 

#endif
