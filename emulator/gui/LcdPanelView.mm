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
    NSFont *                _font;
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

    _font = [NSFont fontWithName:@"Modern DOS 8x16" size:16.0];

    CGContextRef gfx = self.gfxContext.CGContext;
    
    // Black out the screen.
    CGContextSetRGBFillColor(gfx, 0, 0, 0, 1);
    CGContextSetRGBStrokeColor(gfx, 0, 0, 0, 1);
    CGContextFillRect(gfx, self.bounds);

    return self;
}

- (NSGraphicsContext *)gfxContext {
    // For some reason, hanging onto the NSGraphicsContext between re-draw cycles did not work, so
    // we make a fresh one each time we need it.
    NSGraphicsContext *gfxContext = [NSGraphicsContext graphicsContextWithBitmapImageRep:_imageRep];
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
    [self setNeedsDisplay:YES];
}

@end
