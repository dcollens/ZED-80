; Bart's Alice 3 boot sound:
; E2, B2, G#3, all 3 channels tone/no noise, all 3 channels on envelope, ~1.3s envelope, rampdown
;     $7B, $01, $FD, $00, $96, $00, $00, $38, $10,$10,$10, $A1,$13, $09, $00,$00
; With IO ports set to output mode, and a test pattern on the outputs:
;     $7B, $01, $FD, $00, $96, $00, $00, $F8, $10,$10,$10, $A1,$13, $09, $A5,$5A
snddat_boot::
    .byte $7B, $01, $FD, $00, $96, $00, $00, $F8, $10,$10,$10, $A1,$13, $09, $A5,$5A
