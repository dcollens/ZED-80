.PHONY: all clean

PRODUCTS := rom_monitor.rom rom_only_test.rom rom_ram_test.rom lcd_test.bin ram_test.bin 

all: $(PRODUCTS)

clean:
	rm -f $(PRODUCTS)

%.rom %.bin: %.asm
	zasm -yu -i $<
