#include <stdlib.h>
#include <stdbool.h>
#include <stdint.h>
#include <stdio.h>
#include <string.h>

#include "file.h"
#include "ioports.h"
#include "ctc.h"
#include "conio.h"

// Keep this small enough to fit in uint8_t
#define BUFSZ	    128

#define Z80_DI	    __asm__("di")
#define Z80_EI	    __asm__("ei")

// For now, we only do 50Hz (hardcoded in the CTC config)
#define FRAME_HZ    50

#define CH_CTRL_A	'\x01'
#define CH_ESC		'\x1b'
#define CH_LEFT_ARROW	'\x11'
#define CH_RIGHT_ARROW	'\x10'
#define CH_UP_ARROW	'\x1e'
#define CH_DOWN_ARROW	'\x1f'

// Skip this many frames backward/forward on user input.
#define SKIP_FRAMES (5 * FRAME_HZ)

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

typedef struct YM_File {
    FILE *fp;

    YM_Header header;

    char const *songname;
    char const *author;
    char const *comment;

    long audio_start;  // offset into file where frame data begins
} YM_File;

static YM_File Current_file;


typedef struct Song_node {
    struct Song_node *prev;
    struct Song_node *next;
    char filename[13];
} Song_node;

struct Song_list {
    Song_node *head;
    Song_node *tail;
    uint16_t count;
} Songs;


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

static void ymfile_close(void) {
    if (Current_file.fp != NULL) {
	fclose(Current_file.fp);
    }
    free(Current_file.songname);
    free(Current_file.author);
    free(Current_file.comment);
    memset(&Current_file, 0, sizeof(Current_file));
}

static bool ymfile_open(char const *filename) {
    ymfile_close();

    Current_file.fp = fopen(filename, "rb");
    if (Current_file.fp == NULL) {
	printf("Error: can't open %s\n", filename);
	goto fail;
    }

    int rc = fread(&Current_file.header, sizeof(Current_file.header), Current_file.fp);
    if (rc != sizeof(Current_file.header)) {
	puts("Error: short read");
	goto fail;
    }

    if (strncmp(Current_file.header.id, "YM6!", 4) != 0
     || strncmp(Current_file.header.check, "LeOnArD!", 8) != 0)
    {
        puts("Error: not a YM6 file");
	goto fail;
    }

    swap32(&Current_file.header.frames);
    swap32(&Current_file.header.attr);
    swap16(&Current_file.header.digidrums);
    swap32(&Current_file.header.ymclock);
    swap16(&Current_file.header.framehz);
    swap32(&Current_file.header.loopframe);
    swap16(&Current_file.header.future);

    Current_file.songname = read_ztstr(Current_file.fp);
    Current_file.author = read_ztstr(Current_file.fp);
    Current_file.comment = read_ztstr(Current_file.fp);

    Current_file.audio_start = ftell(Current_file.fp);

    return true;

fail:
    ymfile_close();
    return false;
}

static void ymfile_print_metadata(void) {
    printf("# Frames    : %lu\n", Current_file.header.frames);
    printf("Attrs       : %lu\n", Current_file.header.attr);
    printf("Digidrums   : %u\n", Current_file.header.digidrums);
    printf("YM Clock    : %lu ", Current_file.header.ymclock);
    if (Current_file.header.ymclock == 2000000) {
	printf("(Atari ST)\n");
    } else if (Current_file.header.ymclock == 1773400) {
	printf("(ZX Spectrum)\n");
    } else {
	printf("(Unknown)\n");
    }
    printf("Frame Hz    : %u\n", Current_file.header.framehz);
    printf("Loop Frame  : %lu\n", Current_file.header.loopframe);
    printf("Future bytes: %u\n", Current_file.header.future);
    printf("Song Name   : \"%s\"\n", Current_file.songname);
    printf("Author Name : \"%s\"\n", Current_file.author);
    printf("Comment     : \"%s\"\n", Current_file.comment);
}

#if 0
static bool check_end(FILE *fp) {
    char buf[4];

    if (fread(buf, sizeof(buf), fp) != sizeof(buf)) return false;

    //printf("End-marker: %c%c%c%c\n", buf[0], buf[1], buf[2], buf[3]);

    return memcmp(buf, "End!", sizeof(buf)) == 0;
}
#endif

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

static const uint8_t Null_frame[16];

// Returns true iff there was room in the ring buffer to write the data frame.
static bool snd_write14(uint8_t const *data) {
    bool success;

    Z80_DI;
    uint8_t tail = Snd_frame_tail;
    uint8_t newTail = tail + 16;
    if (Snd_frame_head == newTail) {
	// Ring buffer is full, so start playback.
	success = false;
    } else {
	// Ring buffer has room, so enqueue the next frame.
	memcpy(&Snd_frame_buffer[tail], data, 14);
	Snd_frame_tail = newTail; 
	success = true;
    }
    Z80_EI;

    return success;
}

static void snd_stop(void) {
    Snd_running = false;

    __asm
	ld	de, #_Null_frame	; DE := Null_frame
	ld	hl, (#0x0001)		; address of CBIOS WBOOT entry point
	ld	bc, #0x33		; offset to CBIOS SNDWRITE entry point
	add	hl, bc			; HL := address of CBIOS SNDWRITE entry point
	ld	b, #14			; write 14 bytes
	ld	c, #0			; starting at register 0
	ex	de, hl			; HL := data, DE := address of SNDWRITE entry point
	call	_jp_de			; call *DE
    __endasm;
}

static void snd_flush(void) {
    Z80_DI;
    Snd_frame_head = Snd_frame_tail = 0;
    Z80_EI;
}

static void snd_drain(void) {
    // Wait for ring buffer to drain.
    while (Snd_running) {
	Z80_DI;
	if (Snd_frame_head == Snd_frame_tail) {
	    // Ring buffer is empty.
	    Snd_running = false;
	}
	Z80_EI;
    }
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

typedef enum Player_state {
    PST_FILL_BUFFER,	    // filling audio ring buffer
    PST_PLAYING,
    PST_PAUSED,
} Player_state;

struct Player {
    Player_state state;

    uint16_t onePercentFrames;
    uint16_t percentFrameCtr;
    uint8_t percent;

    uint8_t secondFrameCtr;
    uint8_t numSeconds;
    uint8_t numMinutes;
    bool needOutput;

    int32_t nextFrame;
} Player;

static void frame_zero(void) {
    Player.percentFrameCtr = 0;
    Player.percent = 0;

    Player.secondFrameCtr = 0;
    Player.numSeconds = 0;
    Player.numMinutes = 0;
    Player.needOutput = true;
    
    Player.nextFrame = 0;
}

static void frame_incr(void) {
    ++Player.nextFrame;
    ++Player.percentFrameCtr;
    ++Player.secondFrameCtr;

    if (Player.percentFrameCtr == Player.onePercentFrames) {
	Player.percentFrameCtr = 0;
	++Player.percent;
    }

    if (Player.secondFrameCtr == FRAME_HZ) {
	Player.secondFrameCtr = 0;
	++Player.numSeconds;
	if (Player.numSeconds == 60) {
	    Player.numSeconds = 0;
	    ++Player.numMinutes;
	}
	Player.needOutput = true;
    }
}

static void frame_seek(int32_t offset) {
    int32_t newFrame = Player.nextFrame + offset;
    if (newFrame < 0) {
	newFrame = 0;
    } else if (newFrame > Current_file.header.frames) {
	newFrame = Current_file.header.frames;
    }

    Player.nextFrame = newFrame;

    Player.percent = newFrame / Player.onePercentFrames;
    Player.percentFrameCtr = newFrame % Player.onePercentFrames;

    uint16_t totalSecs = newFrame / FRAME_HZ;
    Player.numMinutes = totalSecs / 60;
    Player.numSeconds = totalSecs % 60;
    Player.secondFrameCtr = newFrame % FRAME_HZ;

    Player.needOutput = true;
}

void song_add_tail(Song_node *song) {
    song->prev = Songs.tail;
    song->next = NULL;

    if (Songs.head == NULL) {
	Songs.head = song;
    } else {
	Songs.tail->next = song;
    }
    Songs.tail = song;

    ++Songs.count;
}

void song_add_all(char const *filename) {
    FCB fcb;

    fcb_zero(&fcb);
    fcb_set_filename(&fcb, filename);
    uint8_t rc = fcb_search_first(&fcb);
    while (rc != 0xFF) {
	FCB const *dir_entry = (FCB const *)(CPM_DEFAULT_IOBUF + (rc << 5));

	Song_node *song = malloc(sizeof(Song_node));
	if (song == NULL) {
	    puts("Out of memory");
	    break;
	}
	fcb_get_filename(song->filename, dir_entry);
	puts(song->filename);
	song_add_tail(song);

	rc = fcb_search_next();
    }
}

void main(int argc, char *argv[]) {
#if 0
    extern void **__sdcc_heap_free;
    printf("__sdcc_heap_free=%p __sdcc_heap_free->next=%p\n",
	    __sdcc_heap_free, *__sdcc_heap_free);
#endif

    if (argc < 2) {
	puts("Usage: YMPLAY files...");
	return;
    }

    for (uint8_t i = 1; i < argc; ++i) {
	song_add_all(argv[i]);
    }
    if (Songs.count == 0) {
	puts("No files found");
	return;
    }
    printf("%d tracks\n", Songs.count);

    ctc_init();

    Song_node *song = Songs.head;
    while (song != NULL) {
	if (!ymfile_open(song->filename)) {
	    song = song->next;
	    continue;
	}
	printf("%s - %s (%s)\n", Current_file.songname, Current_file.author, song->filename);

	Player.state = PST_FILL_BUFFER;
	Player.onePercentFrames = Current_file.header.frames / 100;
	frame_zero();

	for (; Player.nextFrame < Current_file.header.frames;) {
	    if (Player.state != PST_PAUSED) {
		static uint8_t frameData[16];
		int rc = fread(frameData, sizeof(frameData), Current_file.fp);
		if (rc != sizeof(frameData)) {
		    puts("Error: early EOF on frame data");
		    goto done;
		}
		// Increment all the frame counters.
		frame_incr();

		// Write audio data to sound chip.
		for (;;) {
		    bool wrote = snd_write14(frameData);
		    if (wrote) break;

		    if (Player.state == PST_FILL_BUFFER) {
			Snd_running = true;
			Player.state = PST_PLAYING;
		    }
		}
	    }

	    // Update progress display.
	    if (Player.needOutput) {
		// Print some trailing spaces to overwrite any prior output.
		printf("%u:%02u (%u%%)  \r",
		       Player.numMinutes, Player.numSeconds, Player.percent);
		Player.needOutput = false;
	    }

	    // Check for keyboard input.
	    uint8_t ch = conio_direct_pollchar();
	    switch (ch) {
		case '\0':
		    // No input character available.
		    break;
		case CH_ESC:
		case 'q':
		case 'Q':
		    goto done_playback;
		case ' ':
		    if (Player.state == PST_PLAYING) {
			snd_stop();
			Player.state = PST_PAUSED;
		    } else if (Player.state == PST_PAUSED) {
			Snd_running = true;
			Player.state = PST_PLAYING;
		    }
		    break;
		case CH_CTRL_A:
		    // Seek to start of song.
		    snd_stop();
		    snd_flush();
		    frame_zero();
		    fseek(Current_file.fp, Current_file.audio_start, SEEK_SET);
		    Player.state = PST_FILL_BUFFER;
		    break;
		case 'h':
		case 'H':
		case CH_LEFT_ARROW:
		    // Seek backwards 5s.
		    snd_stop();
		    snd_flush();
		    frame_seek(-SKIP_FRAMES);
		    fseek(Current_file.fp, Current_file.audio_start + (Player.nextFrame << 4), SEEK_SET);
		    Player.state = PST_FILL_BUFFER;
		    break;
		case 'l':
		case 'L':
		case CH_RIGHT_ARROW:
		    // Seek forwards 5s.
		    snd_stop();
		    snd_flush();
		    frame_seek(SKIP_FRAMES);
		    fseek(Current_file.fp, Current_file.audio_start + (Player.nextFrame << 4), SEEK_SET);
		    Player.state = PST_FILL_BUFFER;
		    break;
		case 'j':
		case 'J':
		case CH_DOWN_ARROW:
		    if (song->next != NULL) {
			song = song->next;
			goto new_song;
		    }
		    break;
		case 'k':
		case 'K':
		case CH_UP_ARROW:
		    if (song->prev != NULL) {
			song = song->prev;
			goto new_song;
		    }
		    break;
		default:
		    printf("Input: $%02x\n", ch);
		    break;
	    }
	}
	// Song ended; move on to next one.
	if (song->next != NULL) {
	    song = song->next;
	} else {
	    song = Songs.head;
	}
new_song:
	snd_stop();
	snd_flush();
	ymfile_close();
    }
done_playback:

    // Play any queued samples, then stop the final sound.
    snd_drain();
    snd_stop();

    ctc_fini();

    printf("%u underflows\n", Snd_underflows);

done:
    ymfile_close();
}
