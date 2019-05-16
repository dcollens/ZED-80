//
//  ra8876.cpp
//  gui
//
//  Created by Daniel Collens on 2019-05-16.
//  Copyright © 2019 The Head. All rights reserved.
//

#include <iostream>
#include "ra8876.h"
#include "strutils.hpp"

using std::cout;
using std::endl;

RA8876::RA8876() {
    _status = 0;
    _address = 0;
    _regs.fill(0);
}

void RA8876::write_dat(uint8_t value) {
    cout << "RA8876: ignoring write of $" << to_hex(value)
         << " to register $" << to_hex(_address) << endl;
}
