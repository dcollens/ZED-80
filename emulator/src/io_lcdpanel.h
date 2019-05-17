//
//  io_lcdpanel.h
//  zed-80-emulator
//
//  Created by Daniel Collens on 2019-05-16.

#ifndef io_lcdpanel_h
#define io_lcdpanel_h

#import "ViewController.h"

#include "iodevice.h"
#include "ra8876.h"

class LcdPanelDevice : public IoDevice {
    class Gfx_ops : public RA8876::Gfx_ops {
        typedef RA8876::Color Color;
        typedef RA8876::Point Point;
        
        LcdPanelView *_panelView;
        
        static NSColor *nscolor(Color c);
        static NSRect nsrect(Point p1, Point p2);

    public:
        void set_panel_view(LcdPanelView *panelView) {
            _panelView = panelView;
        }
        
        void draw_line(Color c, Point p1, Point p2) override;
        
        void draw_rect(Color c, Point p1, Point p2) override;
        void fill_rect(Color c, Point p1, Point p2) override;
        
        void draw_triangle(Color c, Point p1, Point p2, Point p3) override;
        void fill_triangle(Color c, Point p1, Point p2, Point p3) override;
        
        void draw_ellipse(Color c, Point center, Point radii) override;
        void fill_ellipse(Color c, Point center, Point radii) override;
    };
    
    Gfx_ops _gfx_ops;
    RA8876 _ra8876;
    ViewController *_uiDelegate;
    
public:
    LcdPanelDevice();
    
    // Print a brief message describing this device.
    virtual void describe(std::ostream &out) const;
    
    // Called at each step of the main CPU emulation.
    virtual uint64_t tickCallback(int numTicks, uint64_t pins);

    void setUiDelegate(ViewController *uiDelegate) {
        _uiDelegate = uiDelegate;
        _gfx_ops.set_panel_view(uiDelegate.lcdPanelView);
    }
};

#endif /* io_lcdpanel_h */
