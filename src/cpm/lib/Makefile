.PHONY: all clean

CRT0 := crt0.rel

ZED80LIB := zed80.lib
ZED80LIB_SRC := putchar.c getchar.c cmdline.c strdup.c fcb.c
ZED80LIB_OBJS := $(ZED80LIB_SRC:%.c=%.rel)

PRODUCTS := $(CRT0) $(ZED80LIB)

all: $(PRODUCTS)

clean:
	rm -f $(PRODUCTS) *.rel *.lst *.sym *.map *.noi *.ihx

%.rel: %.c Makefile
	sdcc --Werror -mz80 --opt-code-size --allow-unsafe-read -c $<

%.rel: %.s Makefile
	sdasz80 -l -o -s -g $<

zed80.lib: $(ZED80LIB_OBJS) Makefile
	sdar -rc $@ $(ZED80LIB_OBJS)
