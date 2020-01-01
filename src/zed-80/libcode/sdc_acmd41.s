; uint8_t sdc_acmd41()
; - send ACMD41 to SD card until it replies with 0x00 (ready)
; - returns in A:
;    0x00: card is ready
;    0x01: card is idle (timed out waiting for transition to ready)
;    0xFF: timeout waiting for command response
; - destroys: BC, HL
#local
sdc_acmd41::
    push    de
    ld	    de, 10000		    ; retries = 10000
loop:
    dec	    de			    ; --retries
    ld	    a, d
    or	    e			    ; test retries == 0?
    jr	    z, timeout		    ; if retries == 0, return 0x01 (card stuck in idle)

    ld	    hl, cmd55_data
    call    sdc_command		    ; send CMD55 (APP_CMD prefix) (destroys BC, HL)
    cp	    0x02		    ; test response < 0x02?
    jr	    nc, done		    ; if response >= 0x02, fail

    ld	    hl, cmd41_data_v1	    ; HL = &cmd41_data_v1
    ld	    a, (SDC_flags)
    and	    SDF_V2		    ; test SDC_flags & SDF_V2
    jr	    z, cardV1		    ; v1 card, so send 4 zero bytes
    ld	    hl, cmd41_data_v2	    ; v2 card, so send 0x40 followed by 3 zero bytes
cardV1:
    call    sdc_command		    ; send CMD41 (actually ACMD41 because of CMD55 prefix)
				    ; (destroys BC, HL)
    cp	    0x01		    ; test response == 0x01?
    jr	    z, loop		    ; continue if card is still 'idle', otherwise return
done:
    pop	    de
    ret
timeout:
    ld	    a, 0x01
    jr	    done

cmd55_data:
    .byte $77, $00,$00,$00,$00, $65
cmd41_data_v1:
    .byte $69, $00,$00,$00,$00, $01	; dummy CRC
cmd41_data_v2:
    .byte $69, $40,$00,$00,$00, $01	; dummy CRC
#endlocal
