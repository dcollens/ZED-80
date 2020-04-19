#include "sound.h"

void snd_write16(uint8_t const *ptr) {
    for (uint8_t i = 0; i < 16; ++i) {
	snd_write(i, *ptr++);
    }
}
