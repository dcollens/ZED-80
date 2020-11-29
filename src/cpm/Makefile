.PHONY: all clean
.PRECIOUS: %.ihx %.rel

LIBDIR := lib
CRT0 := $(LIBDIR)/crt0.rel
ZED80LIBNAME := zed80.lib
ZED80LIB := $(LIBDIR)/$(ZED80LIBNAME)

PRODUCTS := hello.com echo.com cat.com ymplay.com

all: $(PRODUCTS)

clean:
	make -C lib clean
	rm -f $(PRODUCTS) *.rel *.lst *.sym *.map *.noi *.ihx

%.com: %.ihx Makefile
	srec_cat -disable_sequence_warnings $< -intel -offset -0x100 -output $@ -binary

%.ihx: %.rel $(CRT0) $(ZED80LIB) Makefile
	sdldz80 -n -mjwx -i $@ -b _CODE=0x100 \
	    -k /opt/local/share/sdcc/lib/z80 -k $(LIBDIR) \
	    -l $(ZED80LIBNAME) -l z80 \
	    $(CRT0) $< -e

%.rel: %.c Makefile
	sdcc --std-c99 -I $(LIBDIR) --Werror -mz80 --opt-code-size --allow-unsafe-read -c $<

%.rel: %.s Makefile
	sdasz80 -l -o -s -g $<

$(CRT0): Makefile $(LIBDIR)/Makefile $(LIBDIR)/crt0.s
	make -C lib

$(ZED80LIB): Makefile $(LIBDIR)/Makefile $(wildcard $(LIBDIR)/*.c $(LIBDIR)/*.h)
	make -C lib
