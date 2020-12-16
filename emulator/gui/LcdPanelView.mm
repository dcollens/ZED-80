//
//  LcdPanelView.mm
//  zed-80-emulator
//
//  Created by Daniel Collens on 2019-05-16.
//  Copyright © 2019 The Head. All rights reserved.
//

#include <algorithm>

#import "LcdPanelView.h"
#import "StencilFont.h"

using std::clamp;

namespace {

constexpr size_t PANEL_WIDTH = 1024;
constexpr size_t PANEL_HEIGHT = 600;

uint32_t nscolor_to_u32(NSColor *c) {
    CGFloat rf, gf, bf;
    [c getRed:&rf green:&gf blue:&bf alpha:nullptr];
    uint32_t r = clamp(int(rf * 255), 0, 255);
    uint32_t g = clamp(int(gf * 255), 0, 255);
    uint32_t b = clamp(int(bf * 255), 0, 255);
    return (b << 16) | (g << 8) | r;
}

} // namespace

@implementation LcdPanelView {
    NSView *                _cursorView;
    NSTimeInterval          _cursorBlinkPeriod;
    NSTimer *               _cursorBlinkTimer;

    NSBitmapImageRep *      _imageRep;
    NSImage *               _panelImage;
    NSFont *                _font;
    StencilFont *           _stencilFont;
}

- (instancetype)init {
    self = [super init];
    
    _cursorBlinkPeriod = 1.0 / 50;
    _cursorView = [[NSView alloc] initWithFrame:NSZeroRect];
    _cursorView.wantsLayer = YES;
    [self addSubview:_cursorView];
    
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

    _imageRep = [_imageRep bitmapImageRepByRetaggingWithColorSpace:NSColorSpace.sRGBColorSpace];

    _panelImage = [NSImage new];
    [_panelImage addRepresentation:_imageRep];

    _font = [NSFont fontWithName:@"Modern DOS 8x16" size:16];
    _stencilFont = [[StencilFont alloc] initWithFont:_font];

    CGContextRef gfx = self.gfxContext.CGContext;
    
    // Black out the screen.
    CGContextSetRGBFillColor(gfx, 0, 0, 0, 1);
    CGContextSetRGBStrokeColor(gfx, 0, 0, 0, 1);
    CGContextFillRect(gfx, self.bounds);

    return self;
}

- (void)dealloc {
    [self stopCursorBlinkTimer];
}

- (void)stopCursorBlinkTimer {
    [_cursorBlinkTimer invalidate];
    _cursorBlinkTimer = nil;
}

- (void)startCursorBlinkTimer {
    [self stopCursorBlinkTimer];
    
    NSView *cursorView = _cursorView;
    _cursorBlinkTimer = [NSTimer scheduledTimerWithTimeInterval:_cursorBlinkPeriod
                                                        repeats:YES
                                                          block:^(NSTimer * _Nonnull timer) {
        cursorView.hidden = !cursorView.hidden;
    }];
}

- (NSGraphicsContext *)gfxContext {
    // For some reason, hanging onto the NSGraphicsContext between re-draw cycles did not work, so
    // we make a fresh one each time we need it.
    NSGraphicsContext *gfxContext = [NSGraphicsContext graphicsContextWithBitmapImageRep:_imageRep];

    // Make a second context for the purpose of flipping everything upside down. This
    // also flips the text itself, but our isFlipped method flips that back.
    gfxContext = [NSGraphicsContext graphicsContextWithCGContext:gfxContext.CGContext flipped:YES];
    CGContextRef cgContext = gfxContext.CGContext;
    
    // Set up global graphics context parameters.
    CGContextSetAllowsAntialiasing(cgContext, false);
    CGContextSetShouldAntialias(cgContext, false);
    CGContextSetLineWidth(cgContext, 1);

    return gfxContext;
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

// Make origin in upper-left.
- (BOOL)isFlipped {
    return YES;
}

- (void)drawLineFrom:(NSPoint)p1 to:(NSPoint)p2 withColor:(NSColor *)c {
    CGContextRef gfx = self.gfxContext.CGContext;

    CGContextSetStrokeColorWithColor(gfx, c.CGColor);
    CGContextBeginPath(gfx);
    CGContextMoveToPoint(gfx, p1.x, p1.y);
    CGContextAddLineToPoint(gfx, p2.x, p2.y);
    CGContextStrokePath(gfx);
    
    [self setNeedsDisplay:YES];
}

- (void)drawRect:(NSRect)rect withColor:(NSColor *)c {
    CGContextRef gfx = self.gfxContext.CGContext;

    CGContextSetStrokeColorWithColor(gfx, c.CGColor);
    CGContextStrokeRect(gfx, rect);
    
    [self setNeedsDisplay:YES];
}

- (void)fillRect:(NSRect)rect withColor:(NSColor *)c {
    CGContextRef gfx = self.gfxContext.CGContext;

    CGContextSetFillColorWithColor(gfx, c.CGColor);
    CGContextFillRect(gfx, rect);
    
    [self setNeedsDisplay:YES];
}

- (void)drawTriangleFrom:(NSPoint)p1
                      to:(NSPoint)p2
                      to:(NSPoint)p3
               withColor:(NSColor *)c
{
    CGContextRef gfx = self.gfxContext.CGContext;

    CGContextSetStrokeColorWithColor(gfx, c.CGColor);
    CGContextMoveToPoint(gfx, p1.x, p1.y);
    CGContextAddLineToPoint(gfx, p2.x, p2.y);
    CGContextAddLineToPoint(gfx, p3.x, p3.y);
    CGContextClosePath(gfx);
    CGContextStrokePath(gfx);

    [self setNeedsDisplay:YES];
}

- (void)fillTriangleFrom:(NSPoint)p1
                      to:(NSPoint)p2
                      to:(NSPoint)p3
               withColor:(NSColor *)c
{
    CGContextRef gfx = self.gfxContext.CGContext;
    
    CGContextSetFillColorWithColor(gfx, c.CGColor);
    CGContextMoveToPoint(gfx, p1.x, p1.y);
    CGContextAddLineToPoint(gfx, p2.x, p2.y);
    CGContextAddLineToPoint(gfx, p3.x, p3.y);
    CGContextClosePath(gfx);
    CGContextFillPath(gfx);
    
    [self setNeedsDisplay:YES];
}

- (void)drawEllipseAt:(NSPoint)center
            withRadii:(NSSize)radii
                color:(NSColor *)c
{
    CGContextRef gfx = self.gfxContext.CGContext;
    
    CGContextSetStrokeColorWithColor(gfx, c.CGColor);
    CGContextStrokeEllipseInRect(gfx, NSMakeRect(center.x - radii.width, center.y - radii.height,
                                                 radii.width * 2, radii.height * 2));

    [self setNeedsDisplay:YES];
}

- (void)fillEllipseAt:(NSPoint)center
            withRadii:(NSSize)radii
                color:(NSColor *)c
{
    CGContextRef gfx = self.gfxContext.CGContext;
    
    CGContextSetFillColorWithColor(gfx, c.CGColor);
    CGContextFillEllipseInRect(gfx, NSMakeRect(center.x - radii.width, center.y - radii.height,
                                               radii.width * 2, radii.height * 2));
    
    [self setNeedsDisplay:YES];
}

- (void)drawGlyph:(uint8_t)ch
          atPoint:(NSPoint)p
withForegroundColor:(NSColor *)fg
  backgroundColor:(NSColor *)bg
{
#if 0
    NSString *text = [NSString stringWithFormat:@"%c", ch];
    NSDictionary<NSAttributedStringKey, id> *attr = @{
        NSForegroundColorAttributeName: fg,
        NSBackgroundColorAttributeName: bg,
        NSFontAttributeName: _font,
    };
    
    [NSGraphicsContext saveGraphicsState];
    [NSGraphicsContext setCurrentContext:self.gfxContext];
    [text drawAtPoint:p withAttributes:attr];
    [NSGraphicsContext restoreGraphicsState];
#else
    uint32_t fgColor = nscolor_to_u32(fg);
    uint32_t bgColor = nscolor_to_u32(bg);
    
    auto glyphData = [_stencilFont bitmapDataForGlyph:ch];
    auto glyphWidth = _stencilFont.glyphWidth;
    auto glyphHeight = _stencilFont.glyphHeight;
    auto glyphStride = _stencilFont.stride;
    
    uint32_t *imageData = reinterpret_cast<uint32_t *>(_imageRep.bitmapData);
    imageData += ((PANEL_HEIGHT - 1) - static_cast<int>(p.y)) * PANEL_WIDTH;
    for (int y = 0; y < glyphHeight; ++y) {
        size_t dstx = p.x;
        for (int srcx = 0; srcx < glyphWidth; ++srcx, ++dstx) {
            imageData[dstx] = glyphData[srcx] == 0 ? bgColor : fgColor;
        }
        glyphData += glyphStride;
        imageData -= PANEL_WIDTH;
    }
#endif
    
    [self setNeedsDisplay:YES];
}

- (void)setCursorMode:(LcdCursorMode)cursorMode {
    switch (cursorMode) {
        case LcdCursorMode::OFF:
            [self stopCursorBlinkTimer];
            _cursorView.hidden = YES;
            break;
        case LcdCursorMode::BLINKING:
            [self startCursorBlinkTimer];
            _cursorView.hidden = NO;
            break;
        case LcdCursorMode::SOLID:
            [self stopCursorBlinkTimer];
            _cursorView.hidden = NO;
            break;
    }
}

- (void)setCursorPosition:(NSPoint)origin {
    NSRect frame = _cursorView.frame;
    frame.origin = origin;
    _cursorView.frame = frame;
}

- (void)setCursorSize:(NSSize)size {
    NSRect frame = _cursorView.frame;
    frame.size = size;
    _cursorView.frame = frame;
}

- (void)setCursorColor:(NSColor *)c {
    _cursorView.layer.backgroundColor = c.CGColor;
}

- (void)setCursorBlinkPeriod:(NSTimeInterval)blinkPeriod {
    _cursorBlinkPeriod = blinkPeriod;
    [self startCursorBlinkTimer];
}

- (void)copyRect:(NSRect)rect toPoint:(NSPoint)dest {
    [NSGraphicsContext saveGraphicsState];
    [NSGraphicsContext setCurrentContext:self.gfxContext];
    [_panelImage drawAtPoint:dest fromRect:rect operation:NSCompositingOperationCopy fraction:1];
    [NSGraphicsContext restoreGraphicsState];
    
    [self setNeedsDisplay:YES];
}

@end
