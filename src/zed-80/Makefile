.PHONY: all clean

PRODUCTS := rom_monitor.rom rom_only_test.rom rom_ram_test.rom rom_for_emulator.rom \
	lcd_test.bin ram_test.bin sdcard_test.bin song.bin cbios.bin sio_basic.bin \
	forth.bin forth_low.bin \
	lcd_basic.bin lcd_basic_low.bin

all: $(PRODUCTS)

clean:
	rm -f $(PRODUCTS)

# Extra dependencies for ROM monitors.
rom_for_emulator.rom: rom_monitor.asm lcd_basic_low.bin forth_low.bin
rom_monitor.rom: lcd_basic_low.bin forth_low.bin

# Extra dependencies for images that load at address 0.
lcd_basic_low.bin: lcd_basic.asm
forth_low.bin: forth.asm

# Extra dependency for song.
song.bin: ../ym2asm/*.asm

%.rom %.bin: %.asm *.inc libcode/* libdata/*
	zasm -yu -i $<

%.pkt: %.bin
	../pkt/pkt $< > $@
