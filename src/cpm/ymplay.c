#include <stdlib.h>
#include <stdbool.h>
#include <stdint.h>
#include <stdio.h>
#include <string.h>

#define _FILE_IMPL
#include "file.h"
#include "sound.h"
#include "ioports.h"
#include "ctc.h"

// Keep this small enough to fit in uint8_t
#define BUFSZ	    128

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
    int rc;

    rc = fread(header, sizeof(*header), fp);
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

    {
	char *result = strdup(buffer);
	if (result == NULL) {
	    puts("read_ztstr: no memory");
	}
	return result;
    }
}

static bool check_end(FILE *fp) {
    char buf[4];

    if (fread(buf, sizeof(buf), fp) != sizeof(buf)) return false;

    //printf("End-marker: %c%c%c%c\n", buf[0], buf[1], buf[2], buf[3]);

    return memcmp(buf, "End!", sizeof(buf)) == 0;
}

static volatile uint8_t Frame_counter = 0;

static void ctc_snd_isr(void) __naked {
    __asm
	// save registers
	ex	af, af'	    ; ' <-- hack to balance quotes
	exx
	// actual ISR body
	ld	hl, #_Frame_counter
	inc	(hl)
	// restore registers
	exx
	ex	af, af'	    ; ' <-- hack to balance quotes
	// re-enable interrupts and return
	ei
	reti
    __endasm;
}

static void jp_hl(void) __naked {
    __asm
	jp	(hl)
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
    char const *filename;
    FILE *fp;
    YM_Header header;
    char *songname;
    char *authorname;
    char *comment;
    uint32_t frameNum;
    uint32_t missedFrames = 0;
    uint8_t frameData[16];
    uint8_t lastFrameCounter;

    if (argc < 2) {
	puts("Usage: YMPLAY <file.ym>");
	return;
    }

    filename = argv[1];
    fp = fopen(filename, "rb");
    if (fp == NULL) {
	printf("Error: can't open %s\n", filename);
	return;
    }
    
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

    songname = read_ztstr(fp);
    printf("Song Name       : \"%s\"\n", songname);

    authorname = read_ztstr(fp);
    printf("Author Name     : \"%s\"\n", authorname);

    comment = read_ztstr(fp);
    printf("Comment         : \"%s\"\n", comment);

    snd_init();

    ctc_init();

    lastFrameCounter = Frame_counter;
    for (frameNum = 0; frameNum < header.frames; ++frameNum) {
	int rc;

	rc = fread(frameData, sizeof(frameData), fp);
	if (rc != sizeof(frameData)) {
	    puts("Error: early EOF on frame data");
	    goto done;
	}
	//printf("%lu\r", frameNum);

	// Synchronize frame data writes to header.framehz via CTC ISR
	while (lastFrameCounter == Frame_counter);
	if (Frame_counter != (uint8_t)(lastFrameCounter + 1)) {
	    ++missedFrames;
	}
	lastFrameCounter = Frame_counter;
	
	// Write audio data to sound chip.
	snd_write16(frameData);
    }

    ctc_fini();

    // Stop any final sound.
    memset(frameData, 0, sizeof(frameData));
    snd_write16(frameData);

    if (!check_end(fp)) {
	puts("Warning: YM end marker not reached");
    }

    printf("%lu missed frames\n", missedFrames);

done:
    fclose(fp);
}
