.PHONY: all clean

PRODUCTS := rom_monitor.rom rom_only_test.rom rom_ram_test.rom rom_for_emulator.rom \
	lcd_test.bin ram_test.bin sdcard_test.bin forth.bin song.bin

all: $(PRODUCTS)

clean:
	rm -f $(PRODUCTS)

# Extra dependency for emulator ROM monitor.
rom_for_emulator.rom: rom_monitor.asm

# Extra dependency for song.
song.bin: ../ym2asm/*.asm

%.rom %.bin: %.asm *.inc libcode/* libdata/*
	zasm -yu -i $<

%.pkt: %.bin
	../pkt/pkt $< > $@
