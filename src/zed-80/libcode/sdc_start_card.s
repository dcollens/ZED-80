; uint8_t sdc_start_card()
; - tries to reset and communicate with SD card
; - fills in SDC_flags with card parameters
; - returns in A:
;   SDST_OK:		card started successfully
;   SDST_NOTPRESENT:	card not present
;   SDST_FAIL:		card failed to respond
; - destroys: BC, DE, HL
#local
sdc_start_card::
    ld	    de, SDC_flags	    ; DE = &SDC_flags

    xor	    a
    ld	    (de), a		    ; clear the SD card bit flags

    in	    a, (PORT_JOY1)
    and	    JOY1_SDCD		    ; test Card Detect (active low)
    jr	    nz, notPresent	    ; if high, card isn't present

    call    delay_1ms		    ; delay minimum 1ms after power-on

    call    sdc_dummy_clocks	    ; send 80 (minimum 74) clock cycles with CS high and MOSI high

    ; Send CMD0 to reset the card
    ld	    hl, sdc_cmd0_data
    call    sdc_command		    ; send CMD0 to reset the card (destroys BC, HL)
    cp	    0x01		    ; test response == 0x01?
    jr	    nz, fail		    ; response != 0x01: fail

    ; Send CMD8 to determine major version, and unlock v2 features (if present)
    ld	    hl, sdc_cmd8_data
    call    sdc_command_resp4	    ; next we send CMD8 (destroys BC, HL)
    cp	    0xFF		    ; test response == 0xFF?
    jr	    z, fail		    ; if response == 0xFF, fail
    cp	    0x05		    ; test response == 0x05? (illegal command)
    jr	    z, doneCmd8		    ; if response == 0x05, SD Card is v1
    ld	    a, (de)
    or	    SDF_V2
    ld	    (de), a		    ; set V2 flag
doneCmd8:

    ; Send ACMD41 to activate card
    call    sdc_acmd41		    ; next we send ACMD41 (assume CS low & clocks idle)
				    ; (destroys BC, HL)
    or	    a			    ; test response == 0?
    jr	    nz, fail		    ; if response != 0, fail

    ; For v2 cards, send CMD58 to determine if block vs. byte address
    ld	    a, (de)
    and	    SDF_V2		    ; test SDC_flags & SDF_V2
    jr	    z, cardV1
    ld	    hl, sdc_cmd58_data
    call    sdc_command_resp4	    ; send CMD58 (destroys BC, HL)
    or	    a			    ; test response == 0?
    jr	    nz, success		    ; if response != 0, ignore result
    ld	    a, (SDC_buffer)
    and	    0x40		    ; test SDC_buffer[0] & 0x40?
    jr	    z, success		    ; if SDC_buffer[0] & 0x40 == 0, card is byte addressed
    ld	    a, (de)
    or	    SDF_BLOCK
    ld	    (de), a		    ; set BLOCK flag
    jr	    success

cardV1:
    ; For v1 cards, send CMD16 to set block length to 512
    ld	    hl, sdc_cmd16_data
    call    sdc_command		    ; send CMD16 (destroys BC, HL)
    or	    a			    ; test response == 0?
    jr	    nz, fail		    ; if response != 0, fail

success:
    xor	    a			    ; return SDST_OK
    ret

notPresent:
    ld	    a, SDST_NOTPRESENT	    ; card not present
    ret

fail:
    ld	    a, SDST_FAIL	    ; initialization failed
    ret

sdc_cmd0_data:
    .byte $40, $00,$00,$00,$00, $95
sdc_cmd8_data:
    .byte $48, $00,$00,$01,$AA, $87
sdc_cmd58_data:
    .byte $7A, $00,$00,$00,$00, $FD
sdc_cmd16_data:
    .byte $50, $00,$00,$02,$00, $01	; 512-byte block, dummy CRC
#endlocal
