//
//  audiodevice.h
//  zed-80-emulator
//
//  Created by Daniel Collens on 2019-05-23.
//  Copyright © 2019 The Head. All rights reserved.
//

#ifndef audiodevice_h
#define audiodevice_h

#include <AudioToolbox/AudioQueue.h>

#include <deque>

#include "io_sysreg.h"
#include "io_pio.h"
#include "ay38910.h"

/*
 * Not a subclass of IoDevice because it does not sit directly on the Z80 bus, and thus is not
 * managed by the IO MMU.
 */
class AudioDevice {
    static constexpr int AUDIO_OUTPUT_HZ = 44100;
    static constexpr int N_AUDIO_BUFFERS = 16;
    static constexpr int N_SAMPLES_PER_BUFFER = 1024;
    
    uint32_t                        _cpuClockFrequency;
    uint32_t                        _audioClockDivisor;
    ay38910_t                       _chip;
    uint32_t                        _clockCount;
    uint64_t                        _pins;
    
    AudioQueueRef                   _audioQueue;
    std::deque<AudioQueueBufferRef> _audioBuffers;
    
    void initializeAudioQueue();

    void yieldSample(float sample);
    
    static void audioQueueOutputCallback(void *userData, AudioQueueRef audioQueue,
                                         AudioQueueBufferRef buffer);

    void audioQueueOutputCallback(AudioQueueRef audioQueue, AudioQueueBufferRef buffer);

public:
    AudioDevice(uint32_t cpuClockFrequency, uint32_t audioClockDivisor);
    ~AudioDevice();

    // Print a brief message describing this device.
    void describe(std::ostream &out) const;

    // Called on every step of the CPU simulation. 'numTicks' is CPU clock ticks (not audio chip's
    // clock ticks).
    void tickCallback(int numTicks);
    
    // Called when the BC1/BDIR signals in SysReg may have changed, so we may need to simulate an
    // IO request to the audio chip.
    void checkIorq(SysRegDevice const &sysreg, PioDevice &pio);
    
    void reset();
};

#endif /* audiodevice_h */
