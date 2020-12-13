#include <stdlib.h>
#include <stdbool.h>
#include <stdint.h>
#include <stdio.h>
#include <string.h>

#include "file.h"
#include "ioports.h"
#include "ctc.h"
#include "conio.h"

#define Z80_DI	    __asm__("di")
#define Z80_EI	    __asm__("ei")

#define CHIP8_N_REGS	    16
#define CHIP8_RAM_SIZE	    4096
#define CHIP8_STACK_SIZE    16

#define CHIP8_ADDR_MASK	    (CHIP8_RAM_SIZE - 1)

#define CHIP8_SCREEN_WIDTH  64
#define CHIP8_SCREEN_HEIGHT 32

#define CHIP8_FONT_OFFSET   0
#define CHIP8_USER_OFFSET   512

static const uint8_t Font_data[5 * 16] = {
    0xF0, 0x90, 0x90, 0x90, 0xF0, // 0
    0x20, 0x60, 0x20, 0x20, 0x70, // 1
    0xF0, 0x10, 0xF0, 0x80, 0xF0, // 2
    0xF0, 0x10, 0xF0, 0x10, 0xF0, // 3
    0x90, 0x90, 0xF0, 0x10, 0x10, // 4
    0xF0, 0x80, 0xF0, 0x10, 0xF0, // 5
    0xF0, 0x80, 0xF0, 0x90, 0xF0, // 6
    0xF0, 0x10, 0x20, 0x40, 0x40, // 7
    0xF0, 0x90, 0xF0, 0x90, 0xF0, // 8
    0xF0, 0x90, 0xF0, 0x10, 0xF0, // 9
    0xF0, 0x90, 0xF0, 0x90, 0x90, // A
    0xE0, 0x90, 0xE0, 0x90, 0xE0, // B
    0xF0, 0x80, 0x80, 0x80, 0xF0, // C
    0xE0, 0x90, 0x90, 0x90, 0xE0, // D
    0xF0, 0x80, 0xF0, 0x80, 0xF0, // E
    0xF0, 0x80, 0xF0, 0x80, 0x80  // F
};

typedef union Chip8_opcode_t {
    struct {
        uint8_t lo;
        uint8_t hi;
    };
    uint16_t word;
} Chip8_opcode_t;

typedef struct Chip8_t {
    uint8_t V[CHIP8_N_REGS];	// registers V0...VF
    uint16_t I;			// register I
    uint8_t DT;			// delay timer
    uint8_t ST;			// sound timer
    uint16_t PC;		// program counter
    uint8_t SP;			// stack pointer

    Chip8_opcode_t opcode;	// in-progress opcode

    uint16_t stack[CHIP8_STACK_SIZE];

    uint8_t ram[CHIP8_RAM_SIZE];

    uint16_t keyboard;		// 0: key is up, 1: key is down

    bool display_dirty;
    uint8_t display[CHIP8_SCREEN_WIDTH * CHIP8_SCREEN_HEIGHT];
} Chip8_t;

static Chip8_t Chip8;

void chip8_init(void) {
    memset(&Chip8, 0, sizeof(Chip8));

    // Copy in font data.
    memcpy(&Chip8.ram[CHIP8_FONT_OFFSET], Font_data, sizeof(Font_data));

    // Mark display for refresh.
    Chip8.display_dirty = true;

    // Start execution at user offset.
    Chip8.PC = CHIP8_USER_OFFSET;
}

static void chip8_nibble_0(void) {
    switch (Chip8.opcode.word) {
	case 0x00E0: // CLS
	    // Clear the display.
	    memset(&Chip8.display, 0, sizeof(Chip8.display));
	    Chip8.display_dirty = true;
	    break;
	case 0x00EE: // RET
	    // Return from a subroutine.
	    if (Chip8.SP != 0) {
		Chip8.PC = Chip8.stack[--Chip8.SP];
	    }
	    break;
    }
}

static void chip8_nibble_1(void) {
    // 1nnn: JP addr
    // Jump to location nnn.
    Chip8.PC = Chip8.opcode.word & CHIP8_ADDR_MASK;
}

static void chip8_nibble_2(void) {
    // 2nnn: CALL addr
    // Call subroutine at nnn.
    if (Chip8.SP < CHIP8_STACK_SIZE) {
	Chip8.stack[Chip8.SP++] = Chip8.PC;
    }
    Chip8.PC = Chip8.opcode.word & CHIP8_ADDR_MASK;
}

static void chip8_nibble_3(void) {
    // 3xkk: SE Vx, byte
    // Skip next instruction if Vx = kk.
    if (Chip8.V[Chip8.opcode.hi & 0xF] == Chip8.opcode.lo) {
	Chip8.PC = (Chip8.PC + 2) & CHIP8_ADDR_MASK;
    }
}

static void chip8_nibble_4(void) {
    // 4xkk: SNE Vx, byte
    // Skip next instruction if Vx != kk.
    if (Chip8.V[Chip8.opcode.hi & 0xF] != Chip8.opcode.lo) {
	Chip8.PC = (Chip8.PC + 2) & CHIP8_ADDR_MASK;
    }
}

static void chip8_nibble_5(void) {
    // 5xy0: SE Vx, Vy
    // Skip next instruction if Vx = Vy.
    if (Chip8.V[Chip8.opcode.hi & 0xF] == Chip8.V[Chip8.opcode.lo >> 4]) {
	Chip8.PC = (Chip8.PC + 2) & CHIP8_ADDR_MASK;
    }
}

static void chip8_nibble_6(void) {
    // 6xkk: LD Vx, byte
    // Set Vx = kk.
    Chip8.V[Chip8.opcode.hi & 0xF] = Chip8.opcode.lo;
}

static void chip8_nibble_7(void) {
    // 7xkk: ADD Vx, byte
    // Set Vx = Vx + kk.
    Chip8.V[Chip8.opcode.hi & 0xF] += Chip8.opcode.lo;
}

static void chip8_nibble_8(void) {
    uint8_t const x = Chip8.opcode.hi & 0xF;
    uint8_t const y = Chip8.opcode.lo >> 4;
    switch (Chip8.opcode.lo & 0xF) {
	case 0x0:
	    // 8xy0: LD Vx, Vy
	    // Set Vx = Vy.
	    Chip8.V[x] = Chip8.V[y];
	    break;
	case 0x1:
	    // 8xy1: OR Vx, Vy
	    // Set Vx = Vx OR Vy.
	    Chip8.V[x] |= Chip8.V[y];
	    break;
	case 0x2:
	    // 8xy2: AND Vx, Vy
	    // Set Vx = Vx AND Vy.
	    Chip8.V[x] &= Chip8.V[y];
	    break;
	case 0x3:
	    // 8xy3: XOR Vx, Vy
	    // Set Vx = Vx XOR Vy.
	    Chip8.V[x] ^= Chip8.V[y];
	    break;
	case 0x4: {
	    // 8xy4: ADD Vx, Vy
	    // Set Vx = Vx + Vy, set VF = carry.
	    uint16_t sum = (uint16_t)Chip8.V[x] + Chip8.V[y];
	    Chip8.V[0xF] = sum >> 8;
	    Chip8.V[x] = sum;
	    break;
	}
	case 0x5: {
	    // 8xy5: SUB Vx, Vy
	    // Set Vx = Vx - Vy, set VF = NOT borrow.
	    int16_t sum = (int16_t)Chip8.V[x] - Chip8.V[y];
	    Chip8.V[0xF] = ~(sum >> 8) & 1;
	    Chip8.V[x] = sum;
	    break;
	}
	case 0x6:
	    // 8xy6: SHR Vx {, Vy}
	    // Set Vx = Vy SHR 1.
	    Chip8.V[0xF] = Chip8.V[y] & 1;
	    Chip8.V[x] = Chip8.V[y] >> 1;
	    break;
	case 0x7: {
	    // 8xy7: SUBN Vx, Vy
	    // Set Vx = Vy - Vx, set VF = NOT borrow.
	    int16_t sum = (int16_t)Chip8.V[y] - Chip8.V[x];
	    Chip8.V[0xF] = ~(sum >> 8) & 1;
	    Chip8.V[x] = sum;
	    break;
	}
	case 0xE:
	    // 8xyE: SHL Vx {, Vy}
	    // Set Vx = Vy SHL 1.
	    Chip8.V[0xF] = Chip8.V[y] >> 7;
	    Chip8.V[x] = Chip8.V[y] << 1;
	    break;
    }
}

static void chip8_nibble_9(void) {
    // 9xy0: SNE Vx, Vy
    // Skip next instruction if Vx != Vy.
    if (Chip8.V[Chip8.opcode.hi & 0xF] != Chip8.V[Chip8.opcode.lo >> 4]) {
	Chip8.PC = (Chip8.PC + 2) & CHIP8_ADDR_MASK;
    }
}

static void chip8_nibble_A(void) {
    // Annn: LD I, addr
    // Set I = nnn.
    Chip8.I = Chip8.opcode.word & CHIP8_ADDR_MASK;
}

static void chip8_nibble_B(void) {
    // Bnnn: JP V0, addr
    // Jump to location nnn + V0.
    Chip8.PC = (Chip8.opcode.word + Chip8.V[0]) & CHIP8_ADDR_MASK;
}

static void chip8_nibble_C(void) {
    // Cxkk: RND Vx, byte
    // Set Vx = random byte AND kk.
    Chip8.V[Chip8.opcode.hi & 0xF] = rand() & Chip8.opcode.lo;
}

static void chip8_nibble_D(void) {
    // Dxyn: DRW Vx, Vy, nibble
    // Display n-byte sprite starting at memory location I at (Vx, Vy), set VF = collision.
    uint8_t const sx = Chip8.V[Chip8.opcode.hi & 0xF] & (CHIP8_SCREEN_WIDTH - 1);
    uint8_t const sy = Chip8.V[Chip8.opcode.lo >> 4] & (CHIP8_SCREEN_HEIGHT - 1);
    uint8_t const n = Chip8.opcode.lo & 0xF;

    Chip8.V[0xF] = 0;
    for (uint8_t j = 0, y = sy; j < n; ++j, ++y) {
	if (y >= CHIP8_SCREEN_HEIGHT) break;

	uint8_t sprite = Chip8.ram[(Chip8.I + j) & CHIP8_ADDR_MASK];
	if (sprite == 0) continue;

	for (uint8_t i = 0, x = sx, mask = 0x80; i < 8; ++i, ++x, mask >>= 1) {
	    if (x >= CHIP8_SCREEN_WIDTH) break;

	    uint16_t screen_idx = ((uint16_t)y << 6) + x;
	    bool pixel = (sprite & mask) != 0;
	    Chip8.V[0xF] |= Chip8.display[screen_idx] & pixel;
	    Chip8.display[screen_idx] ^= pixel;
	}
    }
    Chip8.display_dirty = true;
}

static void chip8_nibble_E(void) {
    uint8_t const key = Chip8.opcode.hi & 0xF;
    uint16_t const keymask = 1U << key;
    switch (Chip8.opcode.lo) {
	case 0x9E:
	    // Ex9E: SKP Vx
	    // Skip next instruction if key with the value of Vx is pressed.
	    if ((Chip8.keyboard & keymask) != 0) {
		Chip8.PC = (Chip8.PC + 2) & CHIP8_ADDR_MASK;
	    }
	    break;
	case 0xA1:
	    // ExA1: SKNP Vx
	    // Skip next instruction if key with the value of Vx is not pressed.
	    if ((Chip8.keyboard & keymask) == 0) {
		Chip8.PC = (Chip8.PC + 2) & CHIP8_ADDR_MASK;
	    }
	    break;
    }
}

static void chip8_nibble_F(void) {
    uint8_t const x = Chip8.opcode.hi & 0xF;
    switch (Chip8.opcode.lo) {
	case 0x07:
	    // Fx07: LD Vx, DT
	    // Set Vx = delay timer value.
	    Chip8.V[x] = Chip8.DT;
	    break;
	case 0x0A:
	    // Fx0A: LD Vx, K
	    // Wait for a key press, store the value of the key in Vx.
	    if (Chip8.keyboard == 0) {
		// Back up the instruction counter, and re-run this instruction.
		Chip8.PC = (Chip8.PC - 2) & CHIP8_ADDR_MASK;
	    } else {
		uint16_t mask = 1;
		for (uint8_t key = 0; key < 16; ++key, mask <<= 1) {
		    if ((Chip8.keyboard & mask) != 0) {
			Chip8.V[x] = key;
			break;
		    }
		}
	    }
	    break;
	case 0x15:
	    // Fx15: LD DT, Vx
	    // Set delay timer = Vx.
	    Chip8.DT = Chip8.V[x];
	    break;
	case 0x18:
	    // Fx18: LD ST, Vx
	    // Set sound timer = Vx.
	    Chip8.ST = Chip8.V[x];
	    break;
	case 0x1E:
	    // Fx1E: ADD I, Vx
	    // Set I = I + Vx.
	    Chip8.I += Chip8.V[x];
	    break;
	case 0x29:
	    // Fx29: LD F, Vx
	    // Set I = location of sprite for digit Vx.
	    Chip8.I = CHIP8_FONT_OFFSET + 5 * (Chip8.V[x] & 0xF);
	    break;
	case 0x33: {
	    // Fx33: LD B, Vx
	    // Store BCD representation of Vx in memory locations I, I+1, and I+2.
	    uint8_t vx = Chip8.V[x];
	    uint16_t i = Chip8.I;
	    Chip8.ram[i & CHIP8_ADDR_MASK] = vx / 100;
	    Chip8.ram[(i + 1) & CHIP8_ADDR_MASK] = (vx / 10) % 10;
	    Chip8.ram[(i + 2) & CHIP8_ADDR_MASK] = vx % 10;
	    break;
	}
	case 0x55:
	    // Fx55: LD [I], Vx
	    // Store registers V0 through Vx in memory starting at location I.
	    for (uint8_t reg = 0; reg <= x; ++reg) {
		Chip8.ram[Chip8.I++ & CHIP8_ADDR_MASK] = Chip8.V[reg];
	    }
	    break;
	case 0x65:
	    // Fx65: LD Vx, [I]
	    // Read registers V0 through Vx from memory starting at location I.
	    for (uint8_t reg = 0; reg <= x; ++reg) {
		Chip8.V[reg] = Chip8.ram[Chip8.I++ & CHIP8_ADDR_MASK];
	    }
	    break;
    }
}

typedef void (*Chip8_dispatch_t)(void);

static const Chip8_dispatch_t Chip8_dispatch[16] = {
    chip8_nibble_0,
    chip8_nibble_1,
    chip8_nibble_2,
    chip8_nibble_3,
    chip8_nibble_4,
    chip8_nibble_5,
    chip8_nibble_6,
    chip8_nibble_7,
    chip8_nibble_8,
    chip8_nibble_9,
    chip8_nibble_A,
    chip8_nibble_B,
    chip8_nibble_C,
    chip8_nibble_D,
    chip8_nibble_E,
    chip8_nibble_F,
};

// Incremented by 60Hz timer tick.
static volatile uint8_t Chip8_ticks = 0;

static uint8_t min_u8(uint8_t a, uint8_t b) {
    return a < b ? a : b;
}

/*
 * The CHIP-8 keyboard is laid out as follows:
 *  ╔═══╦═══╦═══╦═══╗
 *  ║ 1 ║ 2 ║ 3 ║ C ║
 *  ╠═══╬═══╬═══╬═══╣
 *  ║ 4 ║ 5 ║ 6 ║ D ║
 *  ╠═══╬═══╬═══╬═══╣
 *  ║ 7 ║ 8 ║ 9 ║ E ║
 *  ╠═══╬═══╬═══╬═══╣
 *  ║ A ║ 0 ║ B ║ F ║
 *  ╚═══╩═══╩═══╩═══╝
 *
 * We map these to the PC keyboard as follows:
 *  ╔═══╦═══╦═══╦═══╗
 *  ║ 1 ║ 2 ║ 3 ║ 4 ║
 *  ╠═══╬═══╬═══╬═══╣
 *  ║ Q ║ W ║ E ║ R ║
 *  ╠═══╬═══╬═══╬═══╣
 *  ║ A ║ S ║ D ║ F ║
 *  ╠═══╬═══╬═══╬═══╣
 *  ║ Z ║ X ║ C ║ V ║
 *  ╚═══╩═══╩═══╩═══╝
 *
 */
static int8_t chip8_keyboard_to_keynum(uint8_t ch) {
    switch (ch) {
	case KEY_1: return 0x1;
	case KEY_2: return 0x2;
	case KEY_3: return 0x3;
	case KEY_4: return 0xC;

	case KEY_Q: return 0x4;
	case KEY_W: return 0x5;
	case KEY_E: return 0x6;
	case KEY_R: return 0xD;

	case KEY_A: return 0x7;
	case KEY_S: return 0x8;
	case KEY_D: return 0x9;
	case KEY_F: return 0xE;

	case KEY_Z: return 0xA;
	case KEY_X: return 0x0;
	case KEY_C: return 0xB;
	case KEY_V: return 0xF;
    }
    return -1;
}

static void vt100_home(void) {
    printf("\x1b[H");
}

static void chip8_display(void) {
    vt100_home();

    for (uint8_t y = 0; y < CHIP8_SCREEN_HEIGHT; ++y) {
	for (uint8_t x = 0; x < CHIP8_SCREEN_WIDTH; ++x) {
	    putchar(Chip8.display[(y << 6) + x] ? '#' : ' ');
	}
	putchar('\n');
    }
}

// Returns raw keycode event to process, if any.
static uint8_t chip8_loop(void) {
    // TODO: Sound output
    for (;;) {
	if (Chip8_ticks != 0) {
	    Z80_DI;
	    uint8_t ticks = Chip8_ticks;
	    Chip8_ticks = 0;
	    Z80_EI;

	    Chip8.DT -= min_u8(Chip8.DT, ticks);
	    Chip8.ST -= min_u8(Chip8.ST, ticks);

	    // If the display is dirty, update it.
	    if (Chip8.display_dirty) {
		chip8_display();
		Chip8.display_dirty = false;
	    }
	}

	Chip8.opcode.hi = Chip8.ram[Chip8.PC++];
	Chip8.opcode.lo = Chip8.ram[Chip8.PC++];
	Chip8.PC &= CHIP8_ADDR_MASK;

	// Dispatch off high nibble.
	Chip8_dispatch[Chip8.opcode.hi >> 4]();

	uint8_t key = conio_direct_pollchar();
	if (key == KEY_NONE) continue;

	uint8_t ch = key & ~KEY_RELEASED_MASK;
	int8_t keynum = chip8_keyboard_to_keynum(ch);
	if (keynum < 0) {
	    // Not a CHIP-8 key; let the main loop handle it.
	    return key;
	}
	uint16_t keymask = 1U << keynum;
	if ((key & KEY_RELEASED_MASK) == 0) {
	    Chip8.keyboard |= keymask;
	} else {
	    Chip8.keyboard &= ~keymask;
	}
    }
}

static void ctc_tick_isr(void) __naked {
    // Do not modify IX or IY, or call any routine that does, as they aren't saved/restored!
    __asm
	// save registers
	ex	af, af'			; ' <-- hack to balance quotes
	exx
	// actual ISR body
	ld	hl, #_Chip8_ticks
	inc	(hl)
	// restore registers
	exx
	ex	af, af'			; ' <-- hack to balance quotes
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
	ld	de, #_ctc_tick_isr  ; our ISR
	call	_jp_hl		    ; call *HL

	// CTC channel 2 is used as a timer to divide down the system clock for channel 3
	ld	a, #(CTC_CONTROL | CTC_RESET | CTC_TIMENXT | CTC_AUTO | CTC_RISING | CTC_SCALE16 | CTC_MODETMR)
	out	(PORT_CTC2), a
	ld	a, #204		    ; 10MHz prescale by 16, divide by 204 is 3063.725Hz
	out	(PORT_CTC2), a
	// CTC channel 3 is used as a counter on the 2.5kHz signal from channel 2
	ld	a, #(CTC_CONTROL | CTC_RESET | CTC_TIMENXT | CTC_RISING | CTC_MODECTR | CTC_INTENA)
	out	(PORT_CTC3), a
	ld	a, #51		    ; 3063.725Hz divided by 51 is 60.073Hz
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

static size_t fsize(FILE *fp) {
    long initialpos = ftell(fp);

    int rc = fseek(fp, 0, SEEK_END);
    if (rc < 0) return 0;

    long size = ftell(fp);

    rc = fseek(fp, initialpos, SEEK_SET);
    if (rc < 0) return 0;

    return size;
}

void main(int argc, char *argv[]) {
    if (argc < 2) {
	puts("Usage: CHIP8 romfile");
	return;
    }

    char const *filename = argv[1];
    FILE *fp = fopen(filename, "rb");
    if (fp == NULL) {
	printf("Can't open %s\n", filename);
	return;
    }

    size_t filesize = fsize(fp);
    if (filesize > CHIP8_RAM_SIZE - CHIP8_USER_OFFSET) {
	printf("File too large: %d bytes\n", filesize);
	goto done;
    }
    
    chip8_init();

    printf("Loading %d bytes from %s...", filesize, filename);

    int rc = fread(&Chip8.ram[CHIP8_USER_OFFSET], filesize, fp);
    if (rc != filesize) {
	puts("Short read");
	goto done;
    }

    puts("done");

    ctc_init();

    conio_set_input_mode(CONIO_INPUT_MODE_RAW);

    chip8_display();
    for (;;) {
	uint8_t key = chip8_loop();
	uint8_t ch = key & ~KEY_RELEASED_MASK;
	switch (ch) {
	    case KEY_ESC:
		goto exit_emulator;
	    default:
		printf("Input: $%02x\n", ch);
		break;
	}
    }
exit_emulator:

    ctc_fini();

done:
    if (fp != NULL) {
	fclose(fp);
    }
    conio_set_input_mode(CONIO_INPUT_MODE_COOKED);
}
