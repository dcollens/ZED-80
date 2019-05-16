//
//  ViewController.m
//  gui
//
//  Created by Lawrence Kesteloot on 4/29/19.
//  Copyright © 2019 The Head. All rights reserved.
//

#import <fstream>
#import "ViewController.h"
#import "LcdPanelView.h"
#import "SevenSegmentView.h"
#import "AppDelegate.h"

#include "zed-80.hpp"

using std::cout;
using std::cerr;
using std::endl;
using std::unique_ptr;
using std::make_unique;
using std::make_shared;
using std::array;
using std::vector;
using std::string;
using std::ifstream;

static constexpr size_t SEVEN_SEGMENT_COUNT = 2;

static constexpr CGFloat V_PADDING = 8;

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

@implementation ViewController {
    ZED80 _zed80;
    NSTimer *_emulatorRunTimer;
    LcdPanelView *_lcdPanelView;
    array<SevenSegmentView *,SEVEN_SEGMENT_COUNT> _sevenSegment;
}

- (void)viewDidLoad {
    [super viewDidLoad];

    _lcdPanelView = [LcdPanelView new];
    [self.view addSubview:_lcdPanelView];
    
    for (int i = 0; i < SEVEN_SEGMENT_COUNT; i++) {
        _sevenSegment[i] = [SevenSegmentView new];
        [self.view addSubview:_sevenSegment[i]];
    }
    
    // Resize to fit around content.
    NSRect frame = self.view.frame;
    frame.size.width = _lcdPanelView.intrinsicContentSize.width;
    frame.size.height = _lcdPanelView.intrinsicContentSize.height
            + V_PADDING
            + _sevenSegment[0].intrinsicContentSize.height;
    self.view.frame = frame;

    _zed80.setUiDelegate(self);

    auto romData = loadFile("/Users/lk/mine/zed-80/src/zed-80/rom_only_test.rom");
    if (romData == nullptr) {
        NSLog(@"Can't load file");
    } else {
        _zed80.setRom(std::move(romData));
    }
}

- (void)viewWillLayout {
    [super viewWillLayout];

    NSRect lcdFrame;
    lcdFrame.origin = NSZeroPoint;
    lcdFrame.size = _lcdPanelView.intrinsicContentSize;
    _lcdPanelView.frame = lcdFrame;
    
    for (int i = 0; i < SEVEN_SEGMENT_COUNT; i++) {
        NSSize size = _sevenSegment[i].intrinsicContentSize;
        NSRect frame;
        frame.origin = NSMakePoint(i * size.width, lcdFrame.size.height + V_PADDING);
        frame.size = size;

        _sevenSegment[i].frame = frame;
    }
}

- (void)setSevenSegment:(uint8_t)port to:(uint8_t)value {
    if (port >= SEVEN_SEGMENT_COUNT) {
        NSLog(@"Invalid seven segment port %d", int(port));
        return;
    }

    _sevenSegment[port].value = value;
}

- (void)cancelEmulatorTimer {
    if (_emulatorRunTimer != nil) {
        [_emulatorRunTimer invalidate];
        _emulatorRunTimer = nil;
    }
}

- (IBAction)emulatorRun:(id)sender {
    [self cancelEmulatorTimer];

    NSLog(@"Running emulator");
    uint32_t periodMs = 10;

    _emulatorRunTimer = [NSTimer scheduledTimerWithTimeInterval:periodMs / 1000.0
                                                        repeats:YES
                                                          block:^(NSTimer * _Nonnull timer) {
                                                              self->_zed80.smallRun(periodMs);
                                                          }];
}

- (IBAction)emulatorStop:(id)sender {
    [self cancelEmulatorTimer];
}

@end
