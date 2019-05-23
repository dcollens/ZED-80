//
//  ZedView.m
//  gui
//
//  Created by Lawrence Kesteloot on 5/17/19.
//  Copyright © 2019 The Head. All rights reserved.
//

#import <array>

#import "ZedView.h"
#import "SevenSegmentView.h"
#import "KeycodeMap.h"

static constexpr size_t SEVEN_SEGMENT_COUNT = 2;
static constexpr CGFloat V_PADDING = 8;

@implementation ZedView {
    std::array<SevenSegmentView *,SEVEN_SEGMENT_COUNT> _sevenSegment;
}

- (instancetype)init {
    self = [super init];

    for (int i = 0; i < SEVEN_SEGMENT_COUNT; i++) {
        _sevenSegment[i] = [SevenSegmentView new];
        [self addSubview:_sevenSegment[i]];
    }

    _lcdPanelView = [LcdPanelView new];
    [self addSubview:_lcdPanelView];

    return self;
}

- (void)layout {
    [super layout];

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

- (BOOL)acceptsFirstResponder {
    // So we can get key events.
    return YES;
}

- (void)keyDown:(NSEvent *)event {
    NSArray *codes = [g_KeyPressScanCodes objectForKey:[NSNumber numberWithInteger:[event keyCode]]];
    if (codes == nil) {
        NSLog(@"Warning: No scan codes for key code %d", [event keyCode]);
    } else {
        [self submitScanCodes:codes];
    }
}

- (void)keyUp:(NSEvent *)event {
    NSArray *codes = [g_KeyReleaseScanCodes objectForKey:[NSNumber numberWithInteger:[event keyCode]]];
    if (codes == nil) {
        NSLog(@"Warning: No scan codes for key code %d", [event keyCode]);
    } else {
        [self submitScanCodes:codes];
    }
}

- (void)flagsChanged:(NSEvent *)event {
    NSLog(@"Keyboard modifier flags changed: 0x%08lX", (unsigned long)[event modifierFlags]);
}

- (NSSize)intrinsicContentSize {
    return NSMakeSize(_lcdPanelView.intrinsicContentSize.width,
                      _lcdPanelView.intrinsicContentSize.height
                      + V_PADDING
                      + _sevenSegment[0].intrinsicContentSize.height);
}

- (void)setSevenSegment:(uint8_t)port to:(uint8_t)value {
    if (port >= SEVEN_SEGMENT_COUNT) {
        NSLog(@"Invalid seven segment port %d", int(port));
        return;
    }

    _sevenSegment[port].value = value;
}

- (void)submitScanCodes:(NSArray *)codes {
    NSLog(@"scan codes: %@", codes);
}

@end
