.PHONY: all clean

PRODUCTS := rom_monitor.rom rom_only_test.rom rom_ram_test.rom rom_for_emulator.rom \
	lcd_test.bin ram_test.bin sdcard_test.bin cbios.bin cpm22.sys sio_basic.bin \
	forth.bin forth_low.bin \
	lcd_basic.bin lcd_basic_low.bin \
	sdcard.img

all: $(PRODUCTS)

clean:
	rm -f $(PRODUCTS)

# Extra dependencies for ROM monitors.
rom_for_emulator.rom: rom_monitor.asm lcd_basic_low.bin forth_low.bin cbios.bin
rom_monitor.rom: lcd_basic_low.bin forth_low.bin cbios.bin

# Extra dependencies for images that load at address 0.
lcd_basic_low.bin: lcd_basic.asm
forth_low.bin: forth.asm

# Extra dependency for song.
song.bin: ../ym2asm/*.asm

%.rom %.bin: %.asm *.inc libcode/* libdata/*
	zasm -yu -i $< -o $@

%.sys: %.asm
	zasm -yu -i $< -o $@

%.pkt: %.bin
	../pkt/pkt $< > $@

sdcard.img: Makefile cpm22.sys
	rm -f sdcard.img
	dd if=/dev/zero of=sdcard.img bs=1024 count=8192
	mkfs.cpm -f zed-80 -b cpm22.sys sdcard.img
	for dir in cpm/?; do \
		user=$$(basename $$dir); \
		cpmcp -f zed-80 sdcard.img $$dir/* $$user:; \
	done
	cpmls -f zed-80 -l sdcard.img
