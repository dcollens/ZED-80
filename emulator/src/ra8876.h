//
//  ra8876.h
//  zed-80-emulator
//
//  Created by Daniel Collens on 2019-05-16.
//  Copyright © 2019 The Head. All rights reserved.
//

#ifndef ra8876_h
#define ra8876_h

#include <array>

class RA8876 {
    uint8_t                     _status;
    uint8_t                     _address;
    std::array<uint8_t,256>     _regs;
    
public:
    RA8876();
    
    void write_cmd(uint8_t value) { _address = value; }
    void write_dat(uint8_t value);
    
    uint8_t read_status() const { return _status; }
    uint8_t read_data() const { return _regs.at(_address); }
};

#endif /* ra8876_h */
