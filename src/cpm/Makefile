.PHONY: all clean
.PRECIOUS: %.ihx %.rel

CRT0 := crt0.rel

PRODUCTS := $(CRT0) hello.com

all: $(PRODUCTS)

clean:
	rm -f $(PRODUCTS) *.rel *.lst *.sym *.map *.noi *.ihx

%.com: %.ihx Makefile
	srec_cat $< -intel -offset -0x100 -output $@ -binary

%.ihx: %.rel $(CRT0) Makefile
	sdldz80 -mjwx -i $@ -b _CODE=0x100 -k /opt/local/share/sdcc/lib/z80 -l z80 $(CRT0) $< -e

%.rel: %.c Makefile
	sdcc --Werror -mz80 --opt-code-size --allow-unsafe-read -c $<

%.rel: %.s Makefile
	sdasz80 -l -o -s -g $<
