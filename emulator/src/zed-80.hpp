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

using std::unique_ptr;

class ZED80 {
    shared_ptr<MMU>         _mmu;
    unique_ptr<IOMMU>       _iommu;
    z80_t                   _cpu;

    static uint64_t z80TickCallback(int numTicks, uint64_t pins, void *userData);

    uint64_t tickCallback(int numTicks, uint64_t pins);
    
public:
    ZED80(shared_ptr<MMU> &mmu, unique_ptr<IOMMU> &&iommu);
    
    void run();
};

#endif /* zed_80_hpp */
