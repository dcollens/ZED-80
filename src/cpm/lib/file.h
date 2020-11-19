#ifndef _FILE_H_INCLUDED
#define _FILE_H_INCLUDED

#include <stdio.h>
#include "fcb.h"

#ifdef _FILE_IMPL
typedef struct FILE {
    FCB		fcb;
    uint16_t	block_count;
    uint16_t	cur_block;

    uint8_t	create : 1;
    uint8_t	read : 1;
    uint8_t	write : 1;
    uint8_t	binary : 1;
    uint8_t	eof : 1;

    uint8_t	iobuf[CPM_BLOCK_SIZE];
    uint8_t	bufpos;
} FILE;

#define NO_BLOCK	((uint16_t)-1)
#define NO_BUFPOS	((uint8_t)-1)
#define CTRL_Z		((char)0x1A)

extern uint8_t __frefill(FILE *stream);
#else
typedef struct FILE FILE;
#endif

extern FILE *fopen(const char * restrict path, const char * restrict mode);
extern int fclose(FILE *stream);
extern int fflush(FILE *stream);
extern int feof(FILE *stream);
extern int fgetc(FILE *stream);
extern int fputc(int c, FILE *stream);
extern size_t fread(void * restrict ptr, size_t size, FILE * restrict stream);
extern size_t fwrite(const void * restrict ptr, size_t size, FILE * restrict stream);

#endif
