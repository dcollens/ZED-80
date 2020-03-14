Kbd_input_buffer::  defs KBD_BUFFER_LEN	; input buffer for interrupt-driven keyboard driver
; This is a ring-buffer shared between the PIO port A interrupt handler and the kbd_pollc/kbd_getc
; routines.
;   Kbd_input_head is the index of the oldest waiting character
;   Kbd_input_tail is the index of the newest waiting character
; Thus input characters are consumed from the head, and enqueued at the tail.
; The input buffer is empty when head == tail
; The input buffer is full when head == (tail + 1) & KBD_BUFFER_MASK
; After removing the oldest waiting character, set head = (head + 1) & KBD_BUFFER_MASK
; After adding the newest waiting character, set tail = (tail + 1) & KBD_BUFFER_MASK
