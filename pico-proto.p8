pico-8 cartridge // http://www.pico-8.com
version 41
__lua__
-- pico-proto
-- by langchr86

-- copyright 2024
-- by christian lang
-- is licensed under
-- cc by-nc-sa 4.0

#include menu.lua
#include point.lua
#include cursor.lua
#include enemy.lua
#include table.lua
#include bullet.lua
#include tower.lua
#include lua-star.lua
#include pico-proto.lua
__gfx__
00000000666666660000000088888888bbbbbbbb000000009900009980000008ccc00ccc00000000000000000000000000000000000000000000000000000000
00000000656666660bb00bb080000008b000000b000000009000000908000080cccccccc00000000000000000000000000000000000000000000000000000000
00700700666665660bb33bb080000008b000000b000000000000000000800800ccc99ccc00000000000000000000000000000000000000000000000000000000
0007700066666666003bb30080000008b000000b000c000000000000000880000c9aa9c000088000000000000000000000000000000000000000000000000000
0007700066566666003bb30080000008b000000b0000c00000000000000880000c9aa9c000088000000000000000000000000000000000000000000000000000
00700700666666660bb33bb080000008b000000b000000000000000000800800ccc99ccc00000000000000000000000000000000000000000000000000000000
00000000666666560bb00bb080000008b000000b000000009000000908000080cccccccc00000000000000000000000000000000000000000000000000000000
00000000666666660000000088888888bbbbbbbb000000009900009980000008ccc00ccc00000000000000000000000000000000000000000000000000000000
99000009900000990cc0000000000cc0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
9000000000000009cccc00777700cccc000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0000000000000000cccc7cccccc7cccc000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000cc7cccccccc7cc0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0000000000000000007cccc77cccc700000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
000000000000000000ccc799997ccc00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
000000000000000007ccc99aa99ccc70000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
900000000000000907cc79aaaa97cc70000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
900000000000000907cc79aaaa97cc70000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
000000000000000007ccc99aa99ccc70000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
000000000000000000ccc799997ccc00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0000000000000000007cccc77cccc700000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000cc7cccccccc7cc0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0000000000000000cccc7cccccc7cccc000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
9000000000000009cccc00777700cccc000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
99000009900000990cc0000000000cc0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
__label__
aaa66666aaa6aaa6aaa6aaa6666666666666666666666666666666666666666666666666666666666666666666666666666666666666666666666666aaa6aaa6
a5a66666a5a6a6a6a5a666a665666666656666666566666665666666656666666566666665666666656666666566666665666666656666666566666665a6a6a6
a6a66566aaa6aaa6a6a66aa66666656666666566666665666666656666666566666665666666656666666566666665666666656666666566666665666aa6a5a6
a6a6666666a6a6a6a6a666a666666666666666666666666666666666666666666666666666666666666666666666666666666666666666666666666666a6a6a6
aaa66a6666a6aaa6aaa6aaa6665666666656666666566666665666666656666666566666665666666656666666566666665666666656666666566666aaa6aaa6
66666666666666666666666666666666666666666666666666666666666666666666666666666666666666666666666666666666666666666666666666666666
66666656666666566666665666666656666666566666665666666656666666566666665666666656666666566666665666666656666666566666665666666656
66666666666666666666666666666666666666666666666666666666666666666666666666666666666666666666666666666666666666666666666666666666
6666666600000000000000000000000099c0000990000c9900000000000000000000000000000000000000000000000000000000000000000000000066666666
656666660000000000000000000000009ccc00777700ccc900000000000000000000000000000000000000000000000000000000000000000000000065666666
66666566000000000000000000000000cccc7cccccc7cccc00000000000000000000000000000000000000000000000000000000000000000000000066666566
666666660000000000000000000000000cc7cccccccc7cc000000000000000000000000000000000000000000000000000000000000000000000000066666666
66566666000000000000000000000000007cccc77cccc70000000000000000000000000000000000000000000000000000000000000000000000000066566666
6666666600000000000000000000000000ccc799997ccc0000000000000000000000000000000000000000000000000000000000000000000000000066666666
6666665600000000000000000000000007ccc99aa99ccc7000000000000000000000000000000000000000000000000000000000000000000000000066666656
6666666600000000000000000000000097cc79aaaa97cc7900000000000000000000000000000000000000000000000000000000000000000000000066666666
6666666600000000000000000000000097cc79aaaa97cc7900000000000000000000000000000000000000000000000000000000000000000000000066666666
6566666600000000000000000000000007ccc99aa99ccc7000000000000000000000000000000000000000000000000000000000000000000000000065666666
6666656600000000000000000000000000ccc799997ccc0000000000000000000000000000000000000000000000000000000000000000000000000066666566
66666666000000000000000000000000007cccc77cccc70000000000000000000000000000000000000000000000000000000000000000000000000066666666
665666660000000000000000000000000cc7cccccccc7cc000000000000000000000000000000000000000000000000000000000000000000000000066566666
66666666000000000000000000000000cccc7cccccc7cccc00000000000000000000000000000000000000000000000000000000000000000000000066666666
666666560000000000000000000000009ccc00777700ccc900000000000000000000000000000000000000000000000000000000000000000000000066666656
6666666600000000000000000000000099c0000990000c9900000000000000000000000000000000000000000000000000000000000000000000000066666666
66666666000000000000000000000000000000000cc0000000000cc0000000000000000000000000000000000000000000000000000000000000000066666666
6566666600000000000000000000000000000000cccc00777700cccc000000000000000000000000000000000000000000000000000000000000000065666666
6666656600000000000000000000000000000000cccc7cccccc7cccc000000000000000000000000000000000000000000000000000000000000000066666566
66666666000000000000000000000000000000000cc7cccccccc7cc0000000000000000000000000000000000000000000000000000000000000000066666666
6656666600000000000000000000000000000000007cccc77cccc700000000000000000000000000000000000000000000000000000000000000000066566666
666666660000000000000000000000000000000000ccc799997ccc00000000000000000000000000000000000000000000000000000000000000000066666666
666666560000000000000000000000000000000007ccc99aa99ccc70000000000000000000000000000000000000000000000000000000000000000066666656
666666660000000000000000000000000000000007cc79aaaa97cc70000000000000000000000000000000000000000000000000000000000000000066666666
66666666000000000cc0000000000cc00000000007cc79aaaa97cc70000000000000000000000000000000000000000000000000000000000000000066666666
6566666600000000cccc00777700cccc0000000007ccc99aa99ccc70000000000000000000000000000000000000000000000000000000000000000065666666
6666656600000000cccc7cccccc7cccc0000000000ccc799997ccc00000000000000000000000000000000000000000000000000000000000000000066666566
66666666000000000cc7cccccccc7cc000000000007cccc77cccc700000000000000000000000000000000000000000000000000000000000000000066666666
6656666600000000007cccc77cccc700000000000cc7cccccccc7cc0000000000000000000000000000000000000000000000000000000000000000066566666
666666660000000000ccc799997ccc0000000000cccc7cccccc7cccc000000000000000000000000000000000000000000000000000000000000000066666666
666666560000000007ccc99aa99ccc7000000000cccc00777700cccc000000000000000000000000000000000000000000000000000000000000000066666656
666666660000000007cc79aaaa97cc70000000000cc0000000000cc0000000000000000000000000000000000000000000000000000000000000000066666666
666666660000000007cc79aaaa97cc70000000000cc0000000000cc0000000000000000000000000000000000000000000000000000000000000000066666666
656666660000000007ccc99aa99ccc7000000000cccc00777700cccc000000000000000000000000000000000000000000000000000000000000000065666666
666665660000000000ccc799997ccc0000000000cccc7cccccc7cccc000000000000000000000000000000000000000000000000000000000000000066666566
6666666600000000007cccc77cccc700000000000cc7cccccccc7cc0000000000000000000000000000000000000000000000000000000000000000066666666
66566666000000000cc7cccccccc7cc000000000007cccc77cccc700000000000000000000000000000000000000000000000000000000000000000066566666
6666666600000000cccc7cccccc7cccc0000000000ccc799997ccc00000000000000000000000000000000000000000000000000000000000000000066666666
6666665600000000cccc00777700cccc0000000007ccc99aa99ccc70000000000000000000000000000000000000000000000000000000000000000066666656
66666666000000000cc0000000000cc00000000007cc79aaaa97cc70000000000000000000000000000000000000000000000000000000000000000066666666
666666660000000000000000000000000000000007cc79aaaa97cc70000000000000000000000000000000000000000000000000000000000000000066666666
656666660000000000000000000000000000000007ccc99aa99ccc70000000000000000000000000000000000000000000000000000000000000000065666666
666665660000000000000000000000000000000000ccc799997ccc00000000000000000000000000000000000000000000000000000000000000000066666566
6666666600000000000000000000000000000000007cccc77cccc700000000000000000000000000000000000000000000000000000000000000000066666666
66566666000000000000000000000000000000000cc7cccccccc7cc0000000000000000000000000000000000000000000000000000000000000000066566666
6666666600000000000000000000000000000000cccc7cccccc7cccc000000000000000000000000000000000000000000000000000000000000000066666666
6666665600000000000000000000000000000000cccc00777700cccc000000000000000000000000000000000000000000000000000000000000000066666656
66666666000000000000000000000000000000000cc0000000000cc0000000000000000000000000000000000000000000000000000000000000000066666666
88888888000000000000cccccc0000000cc0000000000cc000000000000000000000000000000000000000000000000000000000000000000000000000000000
80000008000000000000bb00bb000000cccc00777700cccc00000000000000000000000000000000000000000000000000000000000000000000000000000000
80000008000000000000bb33bb000000cccc7cccccc7cccc00000000000000000000000000000000000000000000000000000000000000000000000000000000
800c0008000c0000000c03bb300c00000cc7cccccccc7cc000000000000000000000000000000000000000000000000000000000000000000000000000000000
8000c0080000c0000000c3bb3000c000007cccc77cccc70000000000000000000000000000000000000000000000000000000000000000000000000000000000
80000008000000000000bb33bb00000000ccc799997ccc0000000000000000000000000000000000000000000000000000000000000000000000000000000000
80000008000000000000bb00bb00000007ccc99aa99ccc7000000000000000000000000000000000000000000000000000000000000000000000000000000000
8888888800000000000000000000000007cc79aaaa97cc7000000000000000000000000000000000000000000000000000000000000000000000000000000000
0000000000000000000000000000000007cc79aaaa97cc70000000000cc0000000000cc0000000000000000000000000000000000000000000000000bbbbbbbb
0000000000000000000000000000000007ccc99aa99ccc7000000000cccc00777700cccc000000000000000000000000000000000000000000000000b000000b
0000000000000000000000000000000000ccc799997ccc0000000000cccc7cccccc7cccc000000000000000000000000000000000000000000000000b000000b
0000000000000000000000000cccccc0007cccc77cccc700000000000cc7cccccccc7cc00000000000000000000000000000000000000000000c0000b00c000b
0000000000000000000000000bb088b00cc7cccccccc7cc000000000007cccc77cccc70000000000000000000000000000000000000000000000c000b000c00b
0000000000000000000000000bb388b0cccc7cccccc7cccc0000000000ccc799997ccc00000000000000000000000000000000000000000000000000b000000b
000000000000000000000000003bb300cccc00777700cccc0000000007ccc99aa99ccc70000000000000000000000000000000000000000000000000b000000b
000000000000000000000000003bb3000cc0000000000cc00000000007cc79aaaa97cc70000000000000000000000000000000000000000000000000bbbbbbbb
6666666600000000000000000bb33bb0000000000cc0000000000cc007cc79aaaa97cc7000000000000000000000000000000000000000000000000066666666
6566666600000000000000000bb00bb000000000cccc00777700cccc07ccc99aa99ccc7000000000000000000000000000000000000000000000000065666666
6666656600000000000000000000000000000000cccc7cccccc7cccc00ccc799997ccc0000000000000000000000000000000000000000000000000066666566
666666660000000000000000000c00000ccccc800cc7cccccccc7cc0007cccc77cccc7000000000000000000000000000000000000000000000c000066666666
6656666600000000000000000000c0000bb0cbb0007cccc77cccc7000cc7cccccccc7cc000000000000000000000000000000000000000000000c00066566666
666666660000000000000000000000000bb33bb000ccc799997ccc00cccc7cccccc7cccc00000000000000000000000000000000000000000000000066666666
66666656000000000000000000000000003bb30007cc889aa99ccc70cccc00777700cccc00000000000000000000000000000000000000000000000066666656
66666666000000000000000000000000003bb30007cc88aaaa97cc700cc0000000000cc000000000000000000000000000000000000000000000000066666666
666666660000000000000000000000000bb33bb007cc79aaaa97cc70000000000cc0000000000cc0000000000000000000000000000000000000000066666666
656666660000000000000000000000000bb00bb007ccc99aa99ccc7000000000cccc00777700cccc000000000000000000000000000000000000000065666666
666665660000000000000000000000000000000000ccc799997ccc0000000000cccc7cccccc7cccc000000000000000000000000000000000000000066666566
66666666000000000000000000000000000c0000007cccc77cccc700000000000cc7cccccccc7cc0000000000000000000000000000c0000000c000066666666
665666660000000000000000000000000000c0000cc7cccccccc7cc000000000007cccc77cccc7000000000000000000000000000000c0000000c00066566666
6666666600000000000000000000000000000000cccc7cccccc7cccc0000000000ccc799997ccc00000000000000000000000000000000000000000066666666
6666665600000000000000000000000000000000cccc00777700cccc0000000007ccc99aa99ccc70000000000000000000000000000000000000000066666656
66666666000000000000000000000000000000000cc0000000000cc00000000007cc79aaaa97cc70000000000000000000000000000000000000000066666666
666666660000000000000000000000000000cccc880000000cc0000000000cc007cc79aaaa97cc70000000000000000000000000000000000000000066666666
656666660000000000000000000000000000bb00bb000000cccc00777700cccc07ccc99aa99ccc70000000000000000000000000000000000000000065666666
666665660000000000000000000000000000bb33bb000000cccc7cccccc7cccc00ccc799997ccc00000000000000000000000000000000000000000066666566
66666666000000000000000000000000000c03bb300c00000cc7cccccccc7cc0007cccc77cccc7000000000000000000000c0000000c00000000000066666666
665666660000000000000000000000000000c3bb3000c000007cccc77cccc7000cc7cccccccc7cc000000000000000000000c0000000c0000000000066566666
666666660000000000000000000000000000bb33bb00000000ccc799997ccc00cccc7cccccc7cccc000000000000000000000000000000000000000066666666
666666560000000000000000000000000000bb00bb00000007ccc99aa99ccc70cccc00777700cccc000000000000000000000000000000000000000066666656
66666666000000000000000000000000000000000000000007cc79aaaa97cc700cc0000000000cc0000000000000000000000000000000000000000066666666
66666666000000000000000000000000000000000000000007cc79aaaa97cc700000000000000000000000000000000000000000000000000000000066666666
65666666000000000000000000000000000000000000000007ccc99aa99ccc700000000000000000000000000000000000000000000000000000000065666666
66666566000000000000000000000000000000000000000000ccc799997ccc000000000000000000000000000000000000000000000000000000000066666566
6666666600000000000000000000000000000000000c0000007cccc77cccc7000000000000000000000c0000000c0000000c0000000000000000000066666666
66566666000000000000000000000000000000000000c0000cc7cccccccc7cc000000000000000000000c0000000c0000000c000000000000000000066566666
666666660000000000000000000000000000000000000000cccc7cccccc7cccc0000000000000000000000000000000000000000000000000000000066666666
666666560000000000000000000000000000000000000000cccc00777700cccc0000000000000000000000000000000000000000000000000000000066666656
6666666600000000000000000000000000000000000000000cc0000000000cc00000000000000000000000000000000000000000000000000000000066666666
66666666000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000066666666
65666666000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000065666666
66666566000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000066666566
6666666600000000000000000000000000000000000c0000000c0000000c0000000c0000000c0000000c00000000000000000000000000000000000066666666
66566666000000000000000000000000000000000000c0000000c0000000c0000000c0000000c0000000c0000000000000000000000000000000000066566666
66666666000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000066666666
66666656000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000066666656
66666666000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000066666666
66666666000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000066666666
65666666000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000065666666
66666566000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000066666566
66666666000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000066666666
66566666000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000066566666
66666666000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000066666666
66666656000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000066666656
66666666000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000066666666
66666666666666666666666666666666666666666666666666666666666666666666666666666666666666666666666666666666666666666666666666666666
6aa66aaa656666666aaa6aaa6a6a6aaa656666666566666665666666656666666566666665666666656666666566666665666666656666666566666665666666
66a66a6a6666656666a66a6a6a6a6a66666665666666656666666566666665666666656666666566666665666666656666666566666665666666656666666566
66a66aaa6666666666a66aa66a6a6aa6666666666666666666666666666666666666666666666666666666666666666666666666666666666666666666666666
66a66a6a6656666666a66a6a6a5a6a66665666666656666666566666665666666656666666566666665666666656666666566666665666666656666666566666
6aaa6aaa6666666666a66a6a66aa6aaa666666666666666666666666666666666666666666666666666666666666666666666666666666666666666666666666
66666656666666566666665666666656666666566666665666666656666666566666665666666656666666566666665666666656666666566666665666666656
66666666666666666666666666666666666666666666666666666666666666666666666666666666666666666666666666666666666666666666666666666666

__gff__
0001000000000000010000000000000000000101000000000000000000000000000001010000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
__map__
0101010101010101010101010101010100000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0100000000000000000000000000000100000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0100000000000000000000000000000100000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0100000000000000000000000000000100000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0100000000000000000000000000000100000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0100000000000000000000000000000100000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0100000000000000000000000000000100000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0100000000000000000000000000000100000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0100000000000000000000000000000100000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0100000000000000000000000000000100000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0100000000000000000000000000000100000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0100000000000000000000000000000100000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0100000000000000000000000000000100000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0101010101010101010101010101010100000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
