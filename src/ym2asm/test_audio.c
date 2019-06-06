
#include <stdio.h>

int main()
{
    int count = 200;
    for (int i = 0; i < count; i++) {
        int value = i*4095/(count - 1);

        printf("    .byte $%02X, $%02X, $%02X, $%02X, $%02X, $%02X, $%02X, $%02X, $%02X, $%02X, $%02X, $%02X, $%02X, $%02X, $%02X, $%02X\n",

                // A pitch
                0,
                0,

                // B pitch
                0,
                0,

                // C pitch
                value & 0xFF,
                value >> 8,

                // Noise
                0,

                // Mixer
                0xf8,

                // Amplitude control
                0x00,
                0x00,
                0x0F,

                // Envelope
                0,
                0,
                0,
                
                // I/O ports
                0,
                0);
    }
    printf("Audio_frame_count equ %d\n", count);
}
