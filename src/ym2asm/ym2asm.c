
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <stdint.h>

#define BUFSZ 128

struct ymheader {
    char id[4];
    char check[8];
    uint32_t frames;
    uint32_t attr;
    uint16_t digidrums;
    uint32_t ymclock;
    uint16_t framehz;
    uint32_t loopframe;
    uint16_t future;
};

uint32_t swap32(uint32_t num) {
    return ((num>>24)&0xff) | ((num<<8)&0xff0000) | \
           ((num>>8)&0xff00) | ((num<<24)&0xff000000);
}

uint16_t swap16(uint16_t num) {
    return ((num>>8)&0xff) | ((num<<8)&0xff00);
}

char *ztstr(FILE *ymfile, int limit, char * errctx) {
    char buffer[BUFSZ], *str;
    int i;
    for(i=0; (i <= limit) && (i < BUFSZ); i++) {
        if ( feof(ymfile) ) {
            fprintf(stderr, "Error reading %s: unexpected end-of-file\n", errctx);
            exit(3);
        }
        buffer[i] = fgetc(ymfile);
        if ( buffer[i] == '\0' ) {
            break;
        }
    }
    if ( (i > limit) || (i>= BUFSZ) || (buffer[i] != '\0') ) {
        fprintf(stderr, "Error reading %s: buffer overrun\n", errctx);
        exit(3);
    }
    str = malloc(i+1);
    strncpy(str, buffer, i+1);
    return str;
}

uint32_t beu32(FILE *ymfile, char *errctx) {
    uint32_t num = 0;
    int32_t i;

    for (i = 3; i >= 0; i--) {
        if (feof(ymfile)) {
            fprintf(stderr, "Error reading %s: buffer overrun\n", errctx);
        }
        num = num | ((uint32_t)fgetc(ymfile) << (i*8));
    }

    return num;
}

uint16_t beu16(FILE *ymfile, char *errctx) {
    uint16_t num = 0;
    int32_t i;

    for (i = 1; i >= 0; i--) {
        if (feof(ymfile)) {
            fprintf(stderr, "Error reading %s: buffer overrun\n", errctx);
        }
        num = num | ((uint16_t)fgetc(ymfile) << (i*8));
    }

    return num;
}

void read_header(FILE *ymfile, struct ymheader *header) {
    int i;

    for (i = 0; i < 4; i++) {
        header->id[i] = fgetc(ymfile);
    }
    for (i = 0; i < 8; i++) {
        header->check[i] = fgetc(ymfile);
    }

    if (strncmp(header->id, "YM6!", 4) != 0 ||
            strncmp(header->check, "LeOnArD!", 8) != 0) {

        fprintf(stderr, "Not a YM6 file.\n");
        exit(3);
    }

    header->frames = beu32(ymfile, "header->frames");
    header->attr = beu32(ymfile, "header->attr");
    header->digidrums = beu16(ymfile, "header->digidrums");
    header->ymclock = beu32(ymfile, "header->ymclock");
    header->framehz = beu16(ymfile, "header->framehz");
    header->loopframe = beu32(ymfile, "header->loopframe");
    header->future = beu16(ymfile, "header->future");
}

int main(int argc, char *argv[]) {
    FILE *ymfile = stdin;
    char *ymfilename, *songname, *authorname, *comment;
    struct ymheader header;
    int i;
    uint8_t r, v, z;
    int limit = -1;

    argc--; argv++;

    if (argc > 1 && strcmp(argv[0], "--limit") == 0) {
        argc--; argv++;
        limit = atoi(argv[0]);
        argc--; argv++;
    }

    if (argc != 0) {
        fprintf(stderr, "Usage: ym2bin [options] < ymtune.ym > ymtune.bin\n");
        fprintf(stderr, "Options:\n");
        fprintf(stderr, "    --limit MAX_FRAMES\n");
        return 1;
    }

    read_header(ymfile, &header);

    fprintf(stderr, "Number of frames: %u\n", header.frames);
    fprintf(stderr, "Attributes      : %u\n", header.attr);
    fprintf(stderr, "Digidrums       : %u\n", header.digidrums);
    fprintf(stderr, "AY Clock        : %u ", header.ymclock);
    if      ( header.ymclock == 2000000 ) {  fprintf(stderr, "(Atari ST)\n");  }
    else if ( header.ymclock == 1773400 ) {  fprintf(stderr, "(ZX Spectrum)\n");  }
                                     else {  fprintf(stderr, "(Unknown)\n");  }
    fprintf(stderr, "Frame Hz        : %u\n", header.framehz);
    fprintf(stderr, "Loop Frame      : %u ", header.loopframe);
    fprintf(stderr, header.loopframe == 0 ? "(Beginning)\n" : "\n");
    fprintf(stderr, "\"Future\" bytes  : %u\n", header.future);

    songname = ztstr(ymfile, BUFSZ, "songname");
    fprintf(stderr, "Song Name       : \"%s\"\n", songname);

    authorname = ztstr(ymfile, BUFSZ, "authorname");
    fprintf(stderr, "Author Name     : \"%s\"\n", authorname);

    comment = ztstr(ymfile, BUFSZ, "comment");
    fprintf(stderr, "Comment         : \"%s\"\n", comment);

    int frame_count = 0;
    for (i = 0; i < header.frames; i++) {
        int included = limit == -1 || i < limit;
        if (included) {
            printf("    .byte ");
            frame_count++;
        }
        for (r = 0; r < 16; r++) {
            v = fgetc(ymfile);
            if (included) {
                if (r > 0) {
                    printf(", ");
                }
                printf("$%02X", (int) v);
            }
        }
        if (included) {
            printf("\n");
        }
    }
    printf("Audio_frame_count equ %d\n", frame_count);

    for (i = 0; i < 4; i++) {
        if (fgetc(ymfile) != "End!"[i]) {
            fprintf(stderr, "Warning: End-of-YM6 was not \"End!\"\n");
        }
    }

    fprintf(stderr, "After \"End!\"    : %.2X\n", fgetc(ymfile));

    return 0;
}
