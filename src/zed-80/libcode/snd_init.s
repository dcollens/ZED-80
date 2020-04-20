; void snd_init()
; - set up PIO port B for output
snd_init::
    M_pio_set_portB_mode PIOMODE_OUTPUT
    ret
