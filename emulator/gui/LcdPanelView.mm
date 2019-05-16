//
//  LcdPanelView.mm
//  zed-80-emulator
//
//  Created by Daniel Collens on 2019-05-16.
//Copyright © 2019 The Head. All rights reserved.
//

#import "LcdPanelView.h"

static constexpr size_t PANEL_WIDTH = 1024;
static constexpr size_t PANEL_HEIGHT = 600;

@implementation LcdPanelView {
    NSBitmapImageRep *      _imageRep;
    NSImage *               _panelImage;
    NSGraphicsContext *     _panelCtx;
    CGContextRef            _gfx;
}

- (instancetype)init {
    self = [super init];
    
    _imageRep =
    [[NSBitmapImageRep alloc] initWithBitmapDataPlanes:NULL
                                            pixelsWide:PANEL_WIDTH
                                            pixelsHigh:PANEL_HEIGHT
                                         bitsPerSample:8
                                       samplesPerPixel:3
                                              hasAlpha:NO
                                              isPlanar:NO
                                        colorSpaceName:NSCalibratedRGBColorSpace
                                          bitmapFormat:NSBitmapFormatThirtyTwoBitLittleEndian
                                           bytesPerRow:4 * PANEL_WIDTH
                                          bitsPerPixel:32];
    
    _panelImage = [NSImage new];
    [_panelImage addRepresentation:_imageRep];

    _panelCtx = [NSGraphicsContext graphicsContextWithBitmapImageRep:_imageRep];

    _gfx = _panelCtx.CGContext;
    
    CGContextSetShouldAntialias(_gfx, false);
    CGContextSetRGBFillColor(_gfx, 0, 0, 0, 1);
    CGContextSetRGBStrokeColor(_gfx, 0, 0, 0, 1);
    CGContextFillRect(_gfx, self.bounds);

    // TODO: This is just a test to show how we would draw into the image.
    CGContextSetRGBFillColor(_gfx, 1, 1, 1, 1);
    CGContextFillRect(_gfx, CGRectMake(100, 100, 100, 100));

    return self;
}

- (NSSize)intrinsicContentSize {
    return NSMakeSize(PANEL_WIDTH, PANEL_HEIGHT);
}

- (void)drawRect:(NSRect)dirtyRect {
    [super drawRect:dirtyRect];
    
    [_panelImage drawAtPoint:NSZeroPoint
                    fromRect:NSZeroRect
                   operation:NSCompositingOperationCopy
                    fraction:1];
}

@end
