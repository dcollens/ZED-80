#ifndef _7SEGDISP_H_INCLUDED
#define _7SEGDISP_H_INCLUDED

// 7-segment display map
//      A
//  +-------+
//  |       |
// F|       |B
//  |   G   |
//  +-------+
//  |       |
// E|       |C
//  |   D   |
//  +-------+  .DP

// These values are the bit masks.
#define SEG_A		0x01	// segment A
#define SEG_B		0x02	// segment B
#define SEG_C		0x04	// segment C
#define SEG_D		0x08	// segment D
#define SEG_E		0x10	// segment E
#define SEG_F		0x20	// segment F
#define SEG_G		0x40	// segment G
#define SEG_DP		0x80	// decimal point

#endif
