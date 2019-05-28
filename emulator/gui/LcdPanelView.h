//
//  LcdPanelView.h
//  zed-80-emulator
//
//  Created by Daniel Collens on 2019-05-16.

#import <Cocoa/Cocoa.h>

NS_ASSUME_NONNULL_BEGIN

enum class LcdCursorMode {
    OFF,
    BLINKING,
    SOLID
};

@interface LcdPanelView : NSView

- (void)drawLineFrom:(NSPoint)p1 to:(NSPoint)p2 withColor:(NSColor *)c;

- (void)drawRect:(NSRect)rect withColor:(NSColor *)c;
- (void)fillRect:(NSRect)rect withColor:(NSColor *)c;

- (void)drawTriangleFrom:(NSPoint)p1
                      to:(NSPoint)p2
                      to:(NSPoint)p3
               withColor:(NSColor *)c;
- (void)fillTriangleFrom:(NSPoint)p1
                      to:(NSPoint)p2
                      to:(NSPoint)p3
               withColor:(NSColor *)c;

- (void)drawEllipseAt:(NSPoint)center
            withRadii:(NSSize)radii
                color:(NSColor *)c;
- (void)fillEllipseAt:(NSPoint)center
            withRadii:(NSSize)radii
                color:(NSColor *)c;

- (void)drawGlyph:(uint8_t)ch
          atPoint:(NSPoint)p
withForegroundColor:(NSColor *)fg
  backgroundColor:(NSColor *)bg;

- (void)setCursorMode:(LcdCursorMode)cursorMode;
- (void)setCursorPosition:(NSPoint)origin;
- (void)setCursorSize:(NSSize)size;
- (void)setCursorColor:(NSColor *)c;
- (void)setCursorBlinkPeriod:(NSTimeInterval)blinkPeriod;

- (void)copyRect:(NSRect)rect toPoint:(NSPoint)dest;

@end

NS_ASSUME_NONNULL_END
