//
//  zed-80.hpp
//  zed-80-emulator
//
//  Created by Daniel Collens on 2018-10-26.
//  Copyright © 2018 The Head. All rights reserved.
//

#ifndef zed_80_hpp
#define zed_80_hpp

#include "mmu.hpp"
#include "iommu.hpp"
#include "z80.h"
#include "io_joyseg.hpp"

using std::unique_ptr;

class ZED80 {
    unique_ptr<vector<uint8_t>> _ramData;
    unique_ptr<vector<uint8_t>> _romData;
    shared_ptr<SysRegDevice>    _sysRegDevice;
    shared_ptr<JoySegDevice>    _joySegDevice;
    shared_ptr<MMU>             _mmu;
    unique_ptr<IOMMU>           _iommu;
    z80_t                       _cpu;

    static uint64_t z80TickCallback(int numTicks, uint64_t pins, void *userData);

    uint64_t tickCallback(int numTicks, uint64_t pins);
    
public:
    ZED80(unique_ptr<const vector<uint8_t>> &&romData);
    
    void run();
};

#endif /* zed_80_hpp */
