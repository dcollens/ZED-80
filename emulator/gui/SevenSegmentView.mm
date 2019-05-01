//
//  SevenSegmentView.m
//  gui
//
//  Created by Lawrence Kesteloot on 4/30/19.
//  Copyright © 2019 The Head. All rights reserved.
//

#import "SevenSegmentView.h"

@interface SevenSegmentView () {
    NSImage *_imageBackground;
    NSImage *_imageSegments[8];
}

@end

@implementation SevenSegmentView

- (instancetype)init {
    self = [super init];

    _value = 0;
    _imageBackground = [NSImage imageNamed:@"SevenSegmentBackground"];
    for (int i = 0; i < 8; i++) {
        NSString *segmentName = [NSString stringWithFormat:@"SevenSegment%02x", (1 << i)];
        _imageSegments[i] = [NSImage imageNamed:segmentName];
    }

    return self;
}

- (NSSize)size {
    return _imageBackground.size;
}


- (void)drawRect:(NSRect)dirtyRect {
    [super drawRect:dirtyRect];

    [_imageBackground drawAtPoint:NSZeroPoint fromRect:NSZeroRect operation:NSCompositingOperationCopy fraction:1.0];
    for (int i = 0; i < 8; i++) {
        if ((_value & (1 << i)) != 0) {
            [_imageSegments[i] drawAtPoint:NSZeroPoint fromRect:NSZeroRect operation:NSCompositingOperationSourceAtop fraction:1.0];
        }
    }
}

- (void)setValue:(uint8_t)value {
    if (value != _value) {
        _value = value;
        self.needsDisplay = YES;
    }
}

@end
