.PHONY: all clean

all: rom_monitor.rom

clean:
	rm -f rom_monitor.rom

%.rom %.bin: %.asm
	zasm -yu -i $<
