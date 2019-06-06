.PHONY: all clean

PRODUCTS := rom_monitor.rom rom_only_test.rom rom_ram_test.rom \
	lcd_test.bin ram_test.bin sdcard_test.bin rom_for_emulator.rom

all: $(PRODUCTS)

clean:
	rm -f $(PRODUCTS)

# Extra dependency for emulator ROM monitor.
rom_for_emulator.rom: rom_monitor.asm

%.rom %.bin: %.asm *.inc libcode/* libdata/*
	zasm -yu -i $<

%.pkt: %.bin
	../pkt/pkt $< > $@
