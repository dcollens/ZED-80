.PHONY: all clean

PRODUCTS := rom_monitor.rom rom_monitor_basic.rom

all: $(PRODUCTS)

clean:
	rm -f $(PRODUCTS)

%.rom %.bin: %.asm
	zasm -yu -i $<
