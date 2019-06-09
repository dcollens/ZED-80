: / /mod swap drop ;
: mod /mod drop ;
: 2dup over over ;
: if immediate ' 0branch , here @ 0000 , ;
: then immediate dup here @ swap - swap ! ;
: else immediate ' branch , here @ 0000 , swap dup here @ swap - swap ! ;
: begin immediate here @ ;
: until immediate ' 0branch , here @ - , ;
: again immediate ' branch , here @ - , ;
: while immediate ' 0branch , here @ 0000 , ;
: repeat immediate ' branch , swap here @ - , dup here @ swap - swap ! ;
: not if 0000 else 0001 then ;
: <= 2dup < -rot = or ;
: > <= not ;
: >= < not ;
: <> = not ;
: space 0020 emit ;
: words latest @ begin ?dup while dup 0003 + tell space @ repeat cr ;
: recurse immediate latest @ >cfa , ;
: decimal 000a base ! ;
: hex 0010 base ! ;
: u. base @ /mod ?dup if recurse then dup 000a < if 0030 else 000a - 0041 then + emit ;
: nip swap drop ; \ ( x y -- y )
: tuck swap over ; \ (x y -- y x y )
: 1+ 0001 + ;
: pick \ ( x_u ... x_1 x_0 u -- x_u ... x_1 x_0 x_u )
    1+ \ add one because of 'u' on the stack
    0002 * \ multiply by the word size
    dsp@ + \ add to the stack pointer
    @ \ and fetch
;
: constant word create ' enter , ' lit , , ' exit , ; \ define a constant
: variable here @ 0000 , word create ' enter , ' lit , , ' exit , ; \ def a var

: rx lcd_width rndn ;
: ry lcd_height rndn ;
: rl rx ry rx ry line ;
: rc rnd rnd rnd color ;
: demo begin rc rl again ;

\ Game.
: joy_read io@ invert 001F and ;
: joy0 joy0_port joy_read ;
: joy1 joy1_port joy_read ;
: min 2dup < if drop else swap drop then ;
: max 2dup < if swap drop else drop then ;
0020 constant size
size 0002 / constant half_size
variable x
variable y
: sprite half_size half_size ellipsef ;
: game
      lcd_width 0002 / x !
      lcd_height 0002 / y !
      begin
           rc x @ y @ sprite
           joy0
               dup joy_up and if y @ half_size > if y @ 0001 - y ! then then
               dup joy_down and if y @ 0001 + lcd_height half_size - min y ! then
               dup joy_left and if x @ half_size > if x @ 0001 - x ! then then
               dup joy_right and if x @ 0001 + lcd_width half_size - min x ! then
           drop
      again
;

\ My own array words.
: array here @ dup rot 0002 * + here ! word create ' enter , ' lit , , ' exit , ; \ def an array, specify size in elements
: a[] swap 0002 * + ; \ ( index array -- address )
: a@ a[] @ ; \ ( index array -- value )
: a! a[] ! ; \ ( value index array -- )
: @low @ 00FF and ;
: @high @ 8>> ;
: !low dup @ FF00 and rot 00FF and or swap ! ;
: !high dup @ 00FF and rot 8<< or swap ! ;
: a@low a[] @low ;
: a@high a[] @high ;
: a!low a[] !low ; \ ( value index array -- )
: a!high a[] !high ; \ ( value index array -- )

\ YM2149 editor.
0008 array r           \ YM registers.
variable i 0000 i !    \ currently-selected virtual register (0-12).
: clear 0000 begin dup 0000 swap r a! 0001 + dup 0008 = until drop ;
: hl i @ = if 00FF 0000 00FF else 00FF 00FF 00FF then color ;
: r@    \ Read from registers. Parameter is 0 to 12.
     dup 0000 = if drop 0000 r a@ else
     dup 0001 = if drop 0001 r a@ else
     dup 0002 = if drop 0002 r a@ else
     dup 0003 = if drop 0003 r a@low else
     dup 0004 = if drop 0003 r a@high else
     dup 0005 = if drop 0004 r a@low else
     dup 0006 = if drop 0004 r a@high else
     dup 0007 = if drop 0005 r a@low else
     dup 0008 = if drop 0005 r a@high else
     dup 0009 = if drop 0006 r a@low else
     dup 000A = if drop 0006 r a@high else
     dup 000B = if drop 0007 r a@low else
     dup 000C = if drop 0007 r a@high else
     drop FFFF then then then then then then then then then then then then then
;
: r!    \ Write to registers. Parameters are value and index (0 to 12).
     dup 0000 = if drop 0000 r a! else
     dup 0001 = if drop 0001 r a! else
     dup 0002 = if drop 0002 r a! else
     dup 0003 = if drop 0003 r a!low else
     dup 0004 = if drop 0003 r a!high else
     dup 0005 = if drop 0004 r a!low else
     dup 0006 = if drop 0004 r a!high else
     dup 0007 = if drop 0005 r a!low else
     dup 0008 = if drop 0005 r a!high else
     dup 0009 = if drop 0006 r a!low else
     dup 000A = if drop 0006 r a!high else
     dup 000B = if drop 0007 r a!low else
     dup 000C = if drop 0007 r a!high else
     drop then then then then then then then then then then then then then
;
: dump
     0000
     begin
         dup hl
         dup r@
         over 0003 < if . else .b then
         0001 + dup 000D =
     until drop 000D hl cr
;
: loadbeep
     017B 0000 r a!
     00FD 0001 r a!
     0096 0002 r a!
     F800 0003 r a!
     1010 0004 r a!
     A110 0005 r a!
     0913 0006 r a!
     5AA5 0007 r a!
;
\ Wait until the joystick changes. Leaves the new value on the stack.
: joy0_change
     joy0              \ Initial value.
     dup               \ Dummy secondary value.
     begin
         drop          \ Drop secondary value.
         dup           \ Duplicate original.
         joy0          \ Read new value.
         dup -rot      \ Keep it around just in case.
         <>            \ See if it's changed.
     until
     swap drop         \ Keep only new.
;
\ YM editor
: ym
     begin
         dump
         key
               dup 001E = if i @ dup r@ 0001 + swap r! then        \ up
               dup 001F = if i @ dup r@ 0001 - swap r! then        \ down
               dup 0011 = i @ 0000 > and if i @ 0001 - i ! then    \ left
               dup 0010 = i @ 000C < and if i @ 0001 + i ! then    \ right
               dup 0020 = if r play then                           \ space
         0071 = \ q to quit
     until
;
