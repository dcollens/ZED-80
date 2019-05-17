.PHONY: all clean

all: rom_monitor.rom rom_only_test.rom rom_ram_test.rom lcd_test.bin ram_test.bin 

clean:
	rm -f rom_monitor.rom

%.rom %.bin: %.asm
	zasm -yu -i $<
