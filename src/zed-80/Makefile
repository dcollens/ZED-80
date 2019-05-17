.PHONY: all clean

all: rom_monitor.rom lcd_test.bin

clean:
	rm -f rom_monitor.rom

%.rom %.bin: %.asm
	zasm -yu -i $<
