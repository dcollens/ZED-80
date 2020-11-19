#ifndef _FCB_H_INCLUDED
#define _FCB_H_INCLUDED

#include <stdint.h>

/*
 * CP/M File Control Block
 *
 * See http://www.gaby.de/cpm/manuals/archive/cpm22htm/ch5.htm
 */
typedef struct FCB {
    uint8_t	drive;		    // drive code: 0=default, 1=A:, 2=B:, etc.
    char	file_name[8];
    char	file_ext[3];
    uint8_t	extent;
    uint8_t	s1;		    // reserved for CP/M internal use
    uint8_t	s2;		    // reserved for CP/M internal use
    uint8_t	record_count;
    uint8_t	d[16];		    // reserved for CP/M internal use
    uint8_t	current_record;
    uint16_t	random_record;	    // these last two fields are really a 24-bit int
    uint8_t	random_record_hi;
} FCB;

/* FCB in system parameters area below TPA */
#define CPM_DEFAULT_FCB	    ((FCB *)0x005C)

#define CPM_BLOCK_SIZE	    128
#define CPM_BLOCK_SHIFT	    7

/* IO buffer in system parameters area below TPA */
#define CPM_DEFAULT_IOBUF   ((uint8_t *)0x0080)

/* These are FCB utility functions */
extern void fcb_zero(FCB *fcb);
extern void fcb_set_filename(FCB *fcb, char const *filename);

/* These are the real CP/M system calls */
extern uint8_t fcb_open(FCB *fcb);
extern uint8_t fcb_close(FCB *fcb);
extern uint8_t fcb_delete(FCB *fcb);
extern uint8_t fcb_read_seq(FCB *fcb);
extern uint8_t fcb_write_seq(FCB *fcb);
extern uint8_t fcb_create(FCB *fcb);
extern uint8_t fcb_rename(FCB *fcb);
extern uint8_t fcb_read_rand(FCB *fcb);
extern uint8_t fcb_write_rand(FCB *fcb);
extern void fcb_file_size(FCB *fcb);
extern void fcb_set_random_record(FCB *fcb);
extern void fcb_set_dma_address(void *iobuf);

#endif
