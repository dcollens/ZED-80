.PHONY: all clean

CRT0 := crt0.rel

ZED80LIB := zed80.lib
ZED80LIB_SRC := putchar.c getchar.c cmdline.c \
    conio_getchar.c conio_putchar.c conio_poll.c \
    conio_direct_pollchar.c conio_direct_putchar.c \
    fcb_zero.c fcb_set_filename.c fcb_call.c \
    fcb_open.c fcb_close.c fcb_delete.c fcb_read_seq.c fcb_write_seq.c \
    fcb_create.c fcb_rename.c fcb_read_rand.c fcb_write_rand.c \
    fcb_file_size.c fcb_set_random_record.c fcb_set_dma_address.c \
    fopen.c fclose.c fflush.c feof.c fgetc.c fread.c frefill.c \
    sysreg_write.c sysreg_update.c
ZED80LIB_OBJS := $(ZED80LIB_SRC:%.c=%.rel)

PRODUCTS := $(CRT0) $(ZED80LIB)

all: $(PRODUCTS)

clean:
	rm -f $(PRODUCTS) *.rel *.lst *.sym *.map *.noi *.ihx

%.rel: %.c Makefile $(wildcard *.h)
	sdcc --std-c99 --Werror -mz80 --opt-code-size --allow-unsafe-read -c $<

%.rel: %.s Makefile
	sdasz80 -l -o -s -g $<

zed80.lib: $(ZED80LIB_OBJS) Makefile
	rm -f $@
	sdar -rc $@ $(ZED80LIB_OBJS)
