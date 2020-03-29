.PHONY: all clean
.PRECIOUS: %.ihx %.rel

LIBDIR := lib
CRT0 := $(LIBDIR)/crt0.rel
ZED80LIBNAME := zed80.lib
ZED80LIB := $(LIBDIR)/$(ZED80LIBNAME)

PRODUCTS := hello.com echo.com

all: $(PRODUCTS)

clean:
	rm -f $(PRODUCTS) *.rel *.lst *.sym *.map *.noi *.ihx

%.com: %.ihx Makefile
	srec_cat -disable_sequence_warnings $< -intel -offset -0x100 -output $@ -binary

%.ihx: %.rel $(CRT0) $(ZED80LIB) Makefile
	sdldz80 -mjwx -i $@ -b _CODE=0x100 \
	    -k /opt/local/share/sdcc/lib/z80 -k $(LIBDIR) \
	    -l z80 -l $(ZED80LIBNAME) \
	    $(CRT0) $< -e

%.rel: %.c Makefile
	sdcc -I $(LIBDIR) --Werror -mz80 --opt-code-size --allow-unsafe-read -c $<

%.rel: %.s Makefile
	sdasz80 -l -o -s -g $<

$(CRT0) $(ZED80LIB): Makefile
	make -C lib
