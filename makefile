#
# Makefile for libvstring
#

# Commons

CFLAGS = -W -Wall -O2 -Wpointer-arith -Wno-parentheses
CFLAGS += -fno-strict-aliasing -fno-builtin -noixemul
OBJS  = fmtlen.o fmtnew.o fmtput.o freestrarray.o strarraylen.o strcopy.o strlen.o \
 strnew.o vfmtnew.o strncopy.o fmtnput.o strequ.o clonestrarray.o strncmp.o strstr.o \
 strcat.o
LIB = libvstring.a

################################################################################

.PHONY: all clean

all: mos

clean:
	rm -vf $(OBJS) $(LIB) $(DOC)

install: mos
	cp libvstring.h /gg/usr/include/
	cp libvstring.a /gg/usr/lib/

mos: CC = ppc-morphos-gcc-11
mos: AR = ppc-morphos-gcc-ar-11
mos: CFLAGS += -DUSE_INLINE_STDARG
mos: $(LIB)

################################################################################

$(LIB): $(OBJS)
	@echo "Library merging..."
	@$(AR) rs $@ $(OBJS)
	@ls -l *.a

%.o: %.c libvstring.h
	@echo "Compiling $@..."
	@$(CC) $(CFLAGS) -c -o $@ $<
