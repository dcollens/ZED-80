//
//  iommu.hpp
//  zed-80-emulator
//
//  Created by Daniel Collens on 2018-10-27.
//  Copyright © 2018 The Head. All rights reserved.
//

#ifndef iommu_hpp
#define iommu_hpp

#include <memory>

#include "iodevice.h"

using std::shared_ptr;

typedef uint8_t iorq_t;

class IOMMU {
public:
    static constexpr int N_IORQ = 16;

private:
    shared_ptr<IoDevice>    _devices[N_IORQ];
    
public:
    IOMMU() {}
    
    void describe(std::ostream &out) const;

    void setDevice(iorq_t iorq, shared_ptr<IoDevice> device) {
        if (iorq >= N_IORQ) return;
        _devices[iorq] = device;
    }
    
    uint64_t tickCallback(int numTicks, uint64_t pins);
};

#endif /* iommu_hpp */
