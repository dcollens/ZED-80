//
//  ViewController.m
//  gui
//
//  Created by Lawrence Kesteloot on 4/29/19.
//  Copyright © 2019 The Head. All rights reserved.
//

#import "ViewController.h"
#import "AppDelegate.h"
#import "zed-80.hpp"
#import <fstream>

using std::cout;
using std::cerr;
using std::endl;
using std::unique_ptr;
using std::make_unique;
using std::make_shared;
using std::vector;
using std::string;
using std::ifstream;

@interface ViewController () {
    ZED80 _zed80;
    NSTimer *_emulatorRunTimer;
    uint8_t _sevenSegment[2];
}

@end

@implementation ViewController

- (instancetype)init {
    self = [super init];

    _emulatorRunTimer = nil;
    _sevenSegment[0] = 0;
    _sevenSegment[1] = 0;

    return self;
}

static unique_ptr<vector<uint8_t>> loadFile(string const &fileName) {
    ifstream file(fileName, ifstream::in | ifstream::binary);
    if (file.fail()) {
        cerr << "Can't open \"" << fileName << "\" for input" << endl;
        return nullptr;
    }

    file.seekg(0, ifstream::end);
    auto fileSize = file.tellg();
    file.seekg(0);

    auto data = make_unique<vector<uint8_t>>(fileSize);
    file.read(reinterpret_cast<char *>(data->data()), data->size());
    if (file.fail()) {
        cerr << "Error reading \"" << fileName << "\"" << endl;
        return nullptr;
    }
    return data;
}

- (void)viewDidLoad {
    [super viewDidLoad];

    _zed80.setUiDelegate(self);

    auto romData = loadFile("/Users/lk/mine/zed-80/src/zed-80/rom_only_test.rom");
    if (romData == nullptr) {
        NSLog(@"Can't load file");
    } else {
        _zed80.setRom(std::move(romData));
    }
}

- (void)setRepresentedObject:(id)representedObject {
    [super setRepresentedObject:representedObject];

    // Update the view, if already loaded.
}

- (void)setSevenSegment:(uint8_t)port to:(uint8_t)value {
    if (port >= 2) {
        NSLog(@"Invalid seven segment port %d", int(port));
        return;
    }

    if (_sevenSegment[port] != value) {
        _sevenSegment[port] = value;
        NSLog(@"Updated port %d to %x", int(port), int(value));
    }
}

- (void)cancelEmulatorTimer {
    if (_emulatorRunTimer != nil) {
        [_emulatorRunTimer invalidate];
        _emulatorRunTimer = nil;
    }
}

- (IBAction)emulatorRun:(id)sender {
    [self cancelEmulatorTimer];

    uint32_t periodMs = 10;

    _emulatorRunTimer = [NSTimer scheduledTimerWithTimeInterval:periodMs/1000.0 repeats:YES block:^(NSTimer * _Nonnull timer) {

        self->_zed80.smallRun(periodMs);
    }];
}

- (IBAction)emulatorStop:(id)sender {
    [self cancelEmulatorTimer];
}

@end
