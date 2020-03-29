#include <string.h>
#include "fcb.h"

void fcb_zero(FCB *fcb) {
    memset(fcb, 0, sizeof(*fcb));
}
