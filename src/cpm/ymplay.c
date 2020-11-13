#include <stdlib.h>
#include <stdbool.h>
#include <stdint.h>
#include <stdio.h>
#include <string.h>

#define _FILE_IMPL
#include "file.h"
#include "ioports.h"
#include "ctc.h"

// Keep this small enough to fit in uint8_t
#define BUFSZ	    128

#define Z80_DI	    __asm__("di")
#define Z80_EI	    __asm__("ei")

typedef struct YM_Header {
    char id[4];
    char check[8];
    uint32_t frames;
    uint32_t attr;
    uint16_t digidrums;
    uint32_t ymclock;
    uint16_t framehz;
    uint32_t loopframe;
    uint16_t future;
} YM_Header;

static void swap32(uint32_t *num) {
    uint8_t *ptr = (uint8_t *)num;

    uint8_t tmp = ptr[0];
    ptr[0] = ptr[3];
    ptr[3] = tmp;

    tmp = ptr[1];
    ptr[1] = ptr[2];
    ptr[2] = tmp;
}

static void swap16(uint16_t *num) {
    uint8_t *ptr = (uint8_t *)num;
    uint8_t tmp = ptr[0];
    ptr[0] = ptr[1];
    ptr[1] = tmp;
}

static bool read_header(FILE *fp, YM_Header *header) {
    int rc = fread(header, sizeof(*header), fp);
    if (rc != sizeof(*header)) {
	puts("Error: short read");
	return false;
    }

    if (strncmp(header->id, "YM6!", 4) != 0 || strncmp(header->check, "LeOnArD!", 8) != 0) {
        puts("Error: not a YM6 file");
	return false;
    }

    swap32(&header->frames);
    swap32(&header->attr);
    swap16(&header->digidrums);
    swap32(&header->ymclock);
    swap16(&header->framehz);
    swap32(&header->loopframe);
    swap16(&header->future);
    return true;
}

static char *read_ztstr(FILE *fp) {
    char buffer[BUFSZ];
    uint8_t i;

    for (i = 0; i < BUFSZ; ++i) {
	int ch = fgetc(fp);
	if (ch == EOF) {
            puts("read_ztstr: early EOF");
            return NULL;
        }
	buffer[i] = ch;
	if (ch == '\0') break;
    }
    if (i >= BUFSZ) {
	puts("read_ztstr: string too long");
	return NULL;
    }

    char *result = strdup(buffer);
    if (result == NULL) {
	puts("read_ztstr: no memory");
    }
    return result;
}

static bool check_end(FILE *fp) {
    char buf[4];

    if (fread(buf, sizeof(buf), fp) != sizeof(buf)) return false;

    //printf("End-marker: %c%c%c%c\n", buf[0], buf[1], buf[2], buf[3]);

    return memcmp(buf, "End!", sizeof(buf)) == 0;
}

// Size of audio frame ring buffer. The code relies on this value
// so it can just do 8-bit arithmetic and automatically get results mod 256.
#define SND_BUFFER_LEN	    256
#define SND_BUFFER_MASK	    (SND_BUFFER_LEN - 1)

/*
 * This is a ring-buffer shared between the CTC interrupt handler and the main file
 * reading loop.
 *   Snd_frame_head is the index of the oldest waiting audio byte
 *   Snd_frame_tail is the index of the newest waiting audio byte
 * Thus sound frames are consumed from the head, and enqueued at the tail.
 * The frame buffer is empty when head == tail
 * The frame buffer is full when head == (tail + 1) & SND_BUFFER_MASK
 * After removing the oldest waiting byte, set head = (head + 1) & SND_BUFFER_MASK
 * After adding the newest waiting byte, set tail = (tail + 1) & SND_BUFFER_MASK
 */
static volatile uint8_t Snd_frame_head = 0;
static volatile uint8_t Snd_frame_tail = 0;
static volatile uint8_t Snd_frame_buffer[SND_BUFFER_LEN];

static volatile uint8_t Snd_running = false;

static volatile uint16_t Snd_underflows = 0;

static volatile void *Interrupted_SP;
#define ISR_STACK_SIZE 32
static volatile uint8_t Interrupt_stack[ISR_STACK_SIZE];

static void ctc_snd_isr(void) __naked {
    // Do not modify IX or IY, or call any routine that does, as they aren't saved/restored!
    __asm
	// switch to interrupt stack
	ld      (_Interrupted_SP), sp
	ld	sp, #(_Interrupt_stack + ISR_STACK_SIZE)
	// save registers
	ex	af, af'			; ' <-- hack to balance quotes
	exx
	// actual ISR body
	ld	a, (_Snd_running)	; are we active?
	or	a			; test A == 0?
	jr	z, 001$			; leave if A == 0
	ld	a, (_Snd_frame_head)	; A = head
	ld	c, a			; C = head
	ld	a, (_Snd_frame_tail)	; A = tail
	cp	c			; test head == tail?
	jr	z, 002$			; underflow if head == tail
	ld	hl, #_Snd_frame_buffer	; HL = Snd_frame_buffer
	ld	b, #0			; BC = head
	add	hl, bc			; HL = &Snd_frame_buffer[Snd_frame_head]

	ex	de, hl			; DE := data
	ld	hl, (#0x0001)		; address of CBIOS WBOOT entry point
	ld	bc, #0x33		; offset to CBIOS SNDWRITE entry point
	add	hl, bc			; HL := address of CBIOS SNDWRITE entry point
	ld	b, #14			; write 14 bytes
	ld	c, #0			; starting at register 0
	ex	de, hl			; HL := data, DE := address of SNDWRITE entry point
	call	_jp_de			; call *DE

	ld	hl, #_Snd_frame_head	; HL = &Snd_frame_head
	ld	a, (hl)			; A = head
	add	a, #16			; A = (head + 16) % 256
	ld	(hl), a			; Snd_frame_head = (head + 16) % 256

    001$:	; done
	// restore registers
	exx
	ex	af, af'			; ' <-- hack to balance quotes
	// restore user stack
	ld	sp, (_Interrupted_SP)
	// re-enable interrupts and return
	ei
	reti

    002$:	; underflow
	ld	hl, (_Snd_underflows)	; ++Snd_underflows
	inc	hl
	ld	(_Snd_underflows), hl
	jr	001$
    __endasm;
}

static void snd_write14(uint8_t const *data) {
    for (bool done = false; !done;) {
	Z80_DI;
	uint8_t tail = Snd_frame_tail;
	uint8_t newTail = tail + 16;
	if (Snd_frame_head == newTail) {
	    // Ring buffer is full, so start playback.
	    Snd_running = true;
	} else {
	    // Ring buffer has room, so enqueue the next frame.
	    memcpy(&Snd_frame_buffer[tail], data, 14);
	    Snd_frame_tail = newTail; 
	    done = true;
	}
	Z80_EI;
    }
}

static void snd_fini(void) {
    // Wait for ring buffer to drain.
    for (bool done = false; !done;) {
	Z80_DI;
	if (Snd_frame_head == Snd_frame_tail) {
	    // Ring buffer is empty.
	    done = true;
	}
	Z80_EI;
    }
    Snd_running = false;
}

static void jp_hl(void) __naked {
    __asm
	jp	(hl)
    __endasm;
}

static void jp_de(void) __naked {
    __asm
	push	de
	ret
    __endasm;
}

static void ctc_init(void) {
    __asm
	// First, reset and disable interrupts for CTC channel 3.
	ld	a, #(CTC_CONTROL | CTC_RESET | CTC_INTDIS)
	out	(PORT_CTC3), a

	// Next, set CTC vector 3 to point to our ISR.
	ld	hl, (#0x0001)	    ; address of CBIOS WBOOT entry point
	ld	de, #0x30	    ; offset to CBIOS SETCTCISR entry point
	add	hl, de		    ; HL := address of CBIOS SETCTCISR entry point
	ld	c, #3		    ; CTC vector 3
	ld	de, #_ctc_snd_isr   ; our ISR
	call	_jp_hl		    ; call *HL

	// CTC channel 2 is used as a timer to divide down the system clock for channel 3
	ld	a, #(CTC_CONTROL | CTC_RESET | CTC_TIMENXT | CTC_AUTO | CTC_RISING | CTC_SCALE16 | CTC_MODETMR)
	out	(PORT_CTC2), a
	ld	a, #250		    ; 10MHz prescale by 16, divide by 250 is 2.5kHz
	out	(PORT_CTC2), a
	// CTC channel 3 is used as a counter on the 2.5kHz signal from channel 2
	ld	a, #(CTC_CONTROL | CTC_RESET | CTC_TIMENXT | CTC_RISING | CTC_MODECTR | CTC_INTENA)
	out	(PORT_CTC3), a
	ld	a, #50		    ; 2.5kHz divided by 50 is 50Hz
	out	(PORT_CTC3), a
    __endasm;
}

static void ctc_fini(void) {
    __asm
	// Reset and disable interrupts for CTC channel 3.
	ld	a, #(CTC_CONTROL | CTC_RESET | CTC_INTDIS)
	out	(PORT_CTC3), a
    __endasm;
}

void main(int argc, char *argv[]) {
    if (argc < 2) {
	puts("Usage: YMPLAY <file.ym>");
	return;
    }

    char const *filename = argv[1];
    FILE *fp = fopen(filename, "rb");
    if (fp == NULL) {
	printf("Error: can't open %s\n", filename);
	return;
    }
    
    YM_Header header;
    if (!read_header(fp, &header)) {
	goto done;
    }

    printf("Number of frames: %lu\n", header.frames);
    printf("Attributes      : %lu\n", header.attr);
    printf("Digidrums       : %u\n", header.digidrums);
    printf("YM Clock        : %lu ", header.ymclock);
    if (header.ymclock == 2000000) {
	printf("(Atari ST)\n");
    } else if (header.ymclock == 1773400) {
	printf("(ZX Spectrum)\n");
    } else {
	printf("(Unknown)\n");
    }
    printf("Frame Hz        : %u\n", header.framehz);
    printf("Loop Frame      : %lu\n", header.loopframe);
    printf("Future bytes    : %u\n", header.future);

    char *songname = read_ztstr(fp);
    printf("Song Name       : \"%s\"\n", songname);

    char *authorname = read_ztstr(fp);
    printf("Author Name     : \"%s\"\n", authorname);

    char *comment = read_ztstr(fp);
    printf("Comment         : \"%s\"\n", comment);

    ctc_init();

    uint8_t frameData[16];
    for (uint32_t frameNum = 0; frameNum < header.frames; ++frameNum) {
	int rc = fread(frameData, sizeof(frameData), fp);
	if (rc != sizeof(frameData)) {
	    puts("Error: early EOF on frame data");
	    goto done;
	}
	//printf("%lu\r", frameNum);

	// Write audio data to sound chip.
	snd_write14(frameData);
    }

    // Stop any final sound.
    memset(frameData, 0, sizeof(frameData));
    snd_write14(frameData);

    snd_fini();

    ctc_fini();

    if (!check_end(fp)) {
	puts("Warning: YM end marker not reached");
    }

    printf("%u underflows\n", Snd_underflows);

done:
    fclose(fp);
}
