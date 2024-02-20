pico-8 cartridge // http://www.pico-8.com
version 41
__lua__
-- pico-proto
-- by langchr86

-- copyright 2024
-- by christian lang
-- is licensed under
-- cc by-nc-sa 4.0

#include point.lua
#include cursor.lua
#include enemy.lua
#include table.lua
#include lua-star.lua
#include pico-proto.lua
__gfx__
00000000666666660bb00bb088888888bbbbbbbb0000000099000099800000080000000000000000000000000000000000000000000000000000000000000000
00000000656666660bb33bb080000008b000000b0000000090000009080000800000000000000000000000000000000000000000000000000000000000000000
0070070066666566003bb30080000008b000000b0000000000000000008008000000000000000000000000000000000000000000000000000000000000000000
0007700066666666003bb3b080000008b000000b000c000000000000000880000000000000000000000000000000000000000000000000000000000000000000
0007700066566666003bb3b080000008b000000b0000c00000000000000880000000000000000000000000000000000000000000000000000000000000000000
0070070066666666003bb30080000008b000000b0000000000000000008008000000000000000000000000000000000000000000000000000000000000000000
00000000666666560bb33bb080000008b000000b0000000090000009080000800000000000000000000000000000000000000000000000000000000000000000
00000000666666660bb00bb088888888bbbbbbbb0000000099000099800000080000000000000000000000000000000000000000000000000000000000000000
__label__
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000666666660000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000656666660000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000666665660000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000666666660000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000665666660000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000666666660000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000666666560000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000666666660000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000666666660000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000656666660000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000666665660000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000666666660000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000665666660000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000666666660000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000666666560000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000666666660000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000666666660000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000656666660000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000666665660000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000666666660000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000665666660000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000666666660000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000666666560000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000666666660000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000666666660000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000656666660000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000666665660000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000666666660000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000665666660000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000666666660000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000666666560000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000666666660000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
88888888000000000000000000000000666666660000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
80000008000000000000000000000000656666660000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
800cc008000000000000000000000000666665660000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
80c00c08000000000000000000000000666666660000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
80c00c08000000000000000000000000665666660000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
800cc008000000000000000000000000666666660000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
80000008000000000000000000000000666666560000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
88888888000000000000000000000000666666660000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
000000000000000000000000000000006666666600000000000000000000000000000000000000000000000000000000000000000000000000000000bbbbbbbb
000000000000000000000000000000006566666600000000000000000000000000000000000000000000000000000000000000000000000000000000b000000b
00000000000cc000000cc000000cc00066666566000000000000000000000000000000000000000000000000000000000000000000000000000cc000b00cc00b
0000000000c00c0000c00c0000c00c006666666600000000000000000000000000000000000000000000000000000000000000000000000000c00c00b0c00c0b
0000000000c00c0000c00c0000c00c006656666600000000000000000000000000000000000000000000000000000000000000000000000000c00c00b0c00c0b
00000000000cc000000cc000000cc00066666666000000000000000000000000000000000000000000000000000000000000000000000000000cc000b00cc00b
000000000000000000000000000000006666665600000000000000000000000000000000000000000000000000000000000000000000000000000000b000000b
000000000000000000000000000000006666666600000000000000000000000000000000000000000000000000000000000000000000000000000000bbbbbbbb
00000000000000000000000000000000666666660000000000000000990000990000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000656666660000000000000000900000090000000000000000000000000000000000000000000000000000000000000000
000000000000000000000000000cc000666665660000000000000000000000000000000000000000000000000000000000000000000cc000000cc00000000000
00000000000000000000000000c00c0066666666000000000000000000000000000000000000000000000000000000000000000000c00c0000c00c0000000000
00000000000000000000000000c00c0066566666000000000000000000000000000000000000000000000000000000000000000000c00c0000c00c0000000000
000000000000000000000000000cc000666666660000000000000000000000000000000000000000000000000000000000000000000cc000000cc00000000000
00000000000000000000000000000000666666560000000000000000900000090000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000666666660000000000000000990000990000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000666666660000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000656666660000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
000000000000000000000000000cc0006666656600000000000000000000000000000000000000000000000000000000000cc000000cc0000000000000000000
00000000000000000000000000c00c00666666660000000000000000000000000000000000000000000000000000000000c00c0000c00c000000000000000000
00000000000000000000000000c00c00665666660000000000000000000000000000000000000000000000000000000000c00c0000c00c000000000000000000
000000000000000000000000000cc0006666666600000000000000000000000000000000000000000000000000000000000cc000000cc0000000000000000000
00000000000000000000000000000000666666560000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000666666660000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
000000000000000000000000000cc000000cc000000cc000000cc000000cc000000cc000000cc000000cc000000cc000000cc000000000000000000000000000
00000000000000000000000000c00c0000c00c0000c00c0000c00c0000c00c0000c00c0000c00c0000c00c0000c00c0000c00c00000000000000000000000000
00000000000000000000000000c00c0000c00c0000c00c0000c00c0000c00c0000c00c0000c00c0000c00c0000c00c0000c00c00000000000000000000000000
000000000000000000000000000cc000000cc000000cc000000cc000000cc000000cc000000cc000000cc000000cc000000cc000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000

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
