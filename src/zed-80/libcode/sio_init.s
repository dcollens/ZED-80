; void sio_init()
#local
sio_init::
    push    hl
    push    bc
    ; configure SIO port A
    ld	    bc, 0x0700 | PORT_SIOACTL
    ld	    hl, sioA_cfg
    otir
    ; configure SIO port B
    ld	    bc, 0x0700 | PORT_SIOBCTL
    ld	    hl, sioB_cfg
    otir
    pop	    bc
    pop	    hl
    ret

sioA_cfg:
sioB_cfg:
    .byte SIOWR0_CMD_RST_CHAN
    .byte SIOWR0_PTR_R4
    .byte SIOWR4_TXSTOP_1 | SIOWR4_CLK_x16
    ; No need to set up WR1/WR2, as they are only used for interrupts
    .byte SIOWR0_PTR_R3
    .byte SIOWR3_RXENA | SIOWR3_RX_8_BITS
    .byte SIOWR0_PTR_R5
    .byte SIOWR5_RTS | SIOWR5_TXENA | SIOWR5_TX_8_BITS | SIOWR5_DTR
    ; No need to set up WR6/WR7, as they are only used for synchronous modes
#endlocal
