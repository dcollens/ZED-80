/*
 * CP/M command-line parsing
 *
 * See http://www.gaby.de/cpm/manuals/archive/cpm22htm/ch5.htm
 */

#include <stdlib.h>
#include <stdint.h>
#include <string.h>
#include "cmdline.h"

#define CPM_CMDLINE	    ((void *)0x0080)
#define CPM_MAXCMDLINELEN   127

char *__Raw_cmdline = NULL;
int __Argc = 0;
char const **__Argv = NULL;


static char Cmdline_buffer[CPM_MAXCMDLINELEN + 1];

void __cmdline_init() {
    // Copy command-line from buffer at 0x0080. First byte is length (up to 127), and the
    // command-line itself follows.
    uint8_t *cpmcmdline = CPM_CMDLINE;
    uint8_t len = *cpmcmdline++;

    memcpy(Cmdline_buffer, cpmcmdline, len);
    Cmdline_buffer[len] = '\0';

    __Raw_cmdline = strdup(Cmdline_buffer);

    __Argv = malloc(sizeof(__Argv[0]));
    if (__Argv != NULL) {
	__Argc = 1;
	__Argv[0] = "";	    // We can't get our executable name from CP/M
    }

    {
	char *word = strtok(Cmdline_buffer, " \t");
	while (word != NULL) {
	    __Argv = realloc(__Argv, (__Argc + 1) * sizeof(__Argv[0]));
	    if (__Argv == NULL) break;
	    __Argv[__Argc++] = word;

	    word = strtok(NULL, " \t");
	}
    }
}
