.PHONY: all clean
.PRECIOUS: %.ihx %.rel

CRT0 := crt0.rel

ZED80LIB := zed80.lib
ZED80LIB_SRC := putchar.c getchar.c
ZED80LIB_OBJS := $(ZED80LIB_SRC:%.c=%.rel)

PRODUCTS := $(CRT0) $(ZED80LIB) hello.com

all: $(PRODUCTS)

clean:
	rm -f $(PRODUCTS) *.rel *.lst *.sym *.map *.noi *.ihx

%.com: %.ihx Makefile
	srec_cat $< -intel -offset -0x100 -output $@ -binary

%.ihx: %.rel $(CRT0) $(ZED80LIB) Makefile
	sdldz80 -mjwx -i $@ -b _CODE=0x100 \
	    -k /opt/local/share/sdcc/lib/z80 -l z80 -l $(ZED80LIB) \
	    $(CRT0) $< -e

%.rel: %.c Makefile
	sdcc --Werror -mz80 --opt-code-size --allow-unsafe-read -c $<

%.rel: %.s Makefile
	sdasz80 -l -o -s -g $<

zed80.lib: $(ZED80LIB_OBJS) Makefile
	sdar -rc $@ $(ZED80LIB_OBJS)
