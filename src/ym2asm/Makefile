.PHONY: all clean

PRODUCTS = ym2asm test_audio axelf.asm

all: $(PRODUCTS)

clean:
	rm -f $(PRODUCTS)

ym2asm: ym2asm.c

test_audio: test_audio.c

axelf.asm: ym2asm axelf.ym
	./ym2asm --limit 2000 < axelf.ym > axelf.asm

