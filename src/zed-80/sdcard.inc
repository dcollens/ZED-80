PORT_SDCARD	equ 0x80	    ; read input latch, write output latch

; SD card flags set in the SDC_flags variable.
SDF_PRESENT	equ 0x01	    ; Card present?
SDF_WP		equ 0x02	    ; Card write-protected?
SDF_V2		equ 0x04	    ; Card v2? (Otherwise v1)
SDF_BLOCK	equ 0x08	    ; Card uses block addresses? (Otherwise byte)
