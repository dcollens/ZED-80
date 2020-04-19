#include "sound.h"

void snd_write(uint8_t regnum, uint8_t value) {
    snd_put(SNDBUS_ADDR, regnum);
    snd_put(SNDBUS_WRITE, value);
}
