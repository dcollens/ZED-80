.PHONY: all clean
.PRECIOUS: %.ihx

PRODUCTS := hello.com

all: $(PRODUCTS)

clean:
	rm -f $(PRODUCTS) *.ihx

%.com: %.ihx
	srec_cat $< -intel -offset -0x100 -output $@ -binary

%.ihx: %.c
	sdcc --Werror -mz80 --opt-code-size --allow-unsafe-read --no-std-crt0 --code-loc 0x100 $<
