//
//  audiodevice.mm
//  zed-80-emulator
//
//  Created by Daniel Collens on 2019-05-23.
//  Copyright © 2019 The Head. All rights reserved.
//

#import <Foundation/Foundation.h>

#include "audiodevice.h"
#include "strutils.h"

using std::cout;
using std::endl;

//static
void AudioDevice::audioQueueOutputCallback(void *userData, AudioQueueRef audioQueue,
                                           AudioQueueBufferRef buffer)
{
    static_cast<AudioDevice *>(userData)->audioQueueOutputCallback(audioQueue, buffer);
}

AudioDevice::AudioDevice(uint32_t cpuClockFrequency, uint32_t audioClockDivisor)
: _cpuClockFrequency(cpuClockFrequency), _audioClockDivisor(audioClockDivisor), _clockCount(0),
  _pins(0), _audioQueue(nullptr), _audioQueueStarted(false), _numQueuedSinceReset(0),
  _numUnderflows(0)
{
    ay38910_desc_t desc;
    desc.type = AY38910_TYPE_8910;
    desc.tick_hz = cpuClockFrequency / audioClockDivisor;
    desc.sound_hz = AUDIO_OUTPUT_HZ;
    desc.magnitude = 1;
    desc.in_cb = nullptr;
    desc.out_cb = nullptr;
    desc.user_data = nullptr;
    ay38910_init(&_chip, &desc);
    
    initializeAudioQueue();
}

AudioDevice::~AudioDevice() {
    AudioQueueDispose(_audioQueue, true);
}

void AudioDevice::initializeAudioQueue() {
    AudioStreamBasicDescription desc = {0};
    desc.mBitsPerChannel = 32;
    desc.mBytesPerFrame = 4;
    desc.mBytesPerPacket = 4;
    desc.mChannelsPerFrame = 1;
    desc.mFormatFlags = kLinearPCMFormatFlagIsPacked | kLinearPCMFormatFlagIsFloat;
    desc.mFormatID = kAudioFormatLinearPCM;
    desc.mFramesPerPacket = 1;
    desc.mReserved = 0;
    desc.mSampleRate = AUDIO_OUTPUT_HZ;
    auto result = AudioQueueNewOutput(&desc, audioQueueOutputCallback, this,
                                      CFRunLoopGetMain(), NULL, 0, &_audioQueue);
    if (result != 0) {
        cout << "AudioDevice: could not create output audio queue, error " << result
             << " ($" << to_hex(result) << ")" << endl;
        return;
    }
    
    for (int i = 0; i < N_AUDIO_BUFFERS; ++i) {
        AudioQueueBufferRef buffer = nullptr;
        result = AudioQueueAllocateBuffer(_audioQueue, N_SAMPLES_PER_BUFFER * sizeof(float),
                                          &buffer);
        if (result != 0) {
            cout << "AudioDevice: could not allocate audio output buffer, error " << result
                 << " ($" << to_hex(result) << ")" << endl;
            break;
        }
        
        _audioBuffers.emplace(buffer);
    }
}

void AudioDevice::yieldSample(float sample) {
    if (_audioBuffers.empty()) {
        ++_numUnderflows;
        if (_numUnderflows <= MAX_UNDERFLOW_MSGS) {
            cout << "AudioDevice: audio buffer underflow, discarding sample" << endl;
        }
        return;
    }
    
    auto buffer = _audioBuffers.front();
    float *data = static_cast<float *>(buffer->mAudioData);
    data[buffer->mAudioDataByteSize / sizeof(float)] = sample;
    buffer->mAudioDataByteSize += sizeof(float);
    if (buffer->mAudioDataByteSize >= buffer->mAudioDataBytesCapacity) {
        _audioBuffers.pop();
        auto result = AudioQueueEnqueueBuffer(_audioQueue, buffer, 0, NULL);
        if (result == 0) {
            ++_numQueuedSinceReset;
        } else {
            cout << "AudioDevice: could not enqueue audio output buffer, error " << result
                 << " ($" << to_hex(result) << ")" << endl;
            // Put the buffer back, empty.
            buffer->mAudioDataByteSize = 0;
            _audioBuffers.emplace(buffer);
        }
    }
    
    if (!_audioQueueStarted && _numQueuedSinceReset >= N_QUEUE_BEFORE_START) {
        auto result = AudioQueueStart(_audioQueue, NULL);
        if (result == 0) {
            _audioQueueStarted = true;
        } else {
            cout << "AudioDevice: could not start output audio queue, error " << result
                 << " ($" << to_hex(result) << ")" << endl;
            return;
        }
    }
}

void AudioDevice::describe(std::ostream &out) const {
    out << "AY-3-8910: " << (_cpuClockFrequency / _audioClockDivisor / 1000000) << "MHz clock";
}

// These ticks are CPU clock ticks.
void AudioDevice::tickCallback(int numTicks) {
    _clockCount += numTicks;
    while (_clockCount > _audioClockDivisor) {
        bool sampleReady = ay38910_tick(&_chip);
        if (sampleReady) {
            yieldSample(_chip.sample);
        }
        _clockCount -= _audioClockDivisor;
    }
}

void AudioDevice::checkIorq(SysRegDevice const &sysreg, PioDevice &pio) {
    bool bc1 = sysreg.getBC1();
    bool bdir = sysreg.getBDir();
    if (bc1 != ((_pins & AY38910_BC1) != 0) || bdir != ((_pins & AY38910_BDIR) != 0)) {
        _pins &= ~(AY38910_BC1 | AY38910_BDIR);
        if (bc1) {
            _pins |= AY38910_BC1;
        }
        if (bdir) {
            _pins |= AY38910_BDIR;
        }
        // Always drive the audio chip's data/address input pins from the PIO port B output pins.
        AY38910_SET_DATA(_pins, pio.getPortOutputs(Z80PIO_PORT_B));
        _pins = ay38910_iorq(&_chip, _pins);
        if (!bdir && bc1) {
            // BDIR=0, BC1=1 is a read from the audio chip, so set the PIO port B input pins.
            pio.setPortInputs(Z80PIO_PORT_B, AY38910_GET_DATA(_pins));
        }
    }
}

void AudioDevice::audioQueueOutputCallback(AudioQueueRef audioQueue, AudioQueueBufferRef buffer) {
    buffer->mAudioDataByteSize = 0;
    _audioBuffers.emplace(buffer);
}

void AudioDevice::reset() {
    AudioQueueStop(_audioQueue, true);
    _audioQueueStarted = false;
    _numQueuedSinceReset = 0;
    
    _clockCount = 0;
    _pins = 0;
    ay38910_reset(&_chip);
}
