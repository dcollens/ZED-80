PORT_SDCARD	equ 0x80	    ; read input latch, write output latch

; SD card flags set in the SDC_flags variable.
SDF_V2		equ 0x01	    ; Card v2? (Otherwise v1)
SDF_BLOCK	equ 0x02	    ; Card uses block addresses? (Otherwise byte)

; SD card status values, returned from e.g. sd_start_card().
SDST_OK		equ 0x00	    ; Success
SDST_NOTPRESENT	equ 0x01	    ; Card not present
SDST_FAIL	equ 0x02	    ; Failure
