; void lcd_wait_idle()
; - waits until geometry engine, BTE, text/graphic write complete
lcd_wait_idle::
    in	    a, (PORT_LCDCMD)
    and	    LCDSTAT_BUSY
    jr	    nz, lcd_wait_idle
    ret
