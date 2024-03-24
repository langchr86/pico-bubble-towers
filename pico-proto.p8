pico-8 cartridge // http://www.pico-8.com
version 41
__lua__
-- pico-proto
-- by langchr86

-- copyright 2024
-- by christian lang
-- is licensed under
-- cc by-nc-sa 4.0

#include libs/table.lua
#include libs/lua-star.lua

#include src/utils.lua
#include src/menu.lua
#include src/point.lua
#include src/cursor.lua
#include src/enemy.lua
#include src/bullet.lua
#include src/tower.lua
#include src/wave.lua
#include src/session.lua
#include src/pico-proto.lua

__gfx__
00000000666666666dddddddddddddddddddddd66dddddddddddddd6666666666666666611111111dddddddd0000000000000000000000000000000000000000
00000000dddddddd6dddddddddddddddddddddd66dddddddddddddd66dddddddddddddd611111111dddddddd0000000000000000000000000000000000000000
00700700dddddddd6dddddddddddddddddddddd66dddddddddddddd66dddddddddddddd611111111dddddddd0000000000000000000000000000000000000000
00077000dddddddd6dddddddddddddddddddddd66dddddddddddddd66dddddddddddddd611111111dddddddd0000000000000000000000000000000000000000
00077000dddddddd6dddddddddddddddddddddd66dddddddddddddd66dddddddddddddd611111111dddddddd0000000000000000000000000000000000000000
00700700dddddddd6dddddddddddddddddddddd66dddddddddddddd66dddddddddddddd611111111dddddddd0000000000000000000000000000000000000000
00000000dddddddd6dddddddddddddddddddddd66dddddddddddddd66dddddddddddddd611111111dddddddd0000000000000000000000000000000000000000
00000000dddddddd6ddddddd66666666ddddddd666666666666666666dddddddddddddd611111111dddddddd0000000000000000000000000000000000000000
0000000088888888bbbbbbbb00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0000000082222228b333333b00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0000000082111128b311113b00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
000c000082100128b310013b00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0000c00082100128b310013b00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0000000082111128b311113b00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0000000082222228b333333b00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0000000088888888bbbbbbbb00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0bb00bb000b00b000000000000000000000000000000800000000000000000000000000000000000000000000000000000000000000000000000000000000000
0bb33bb00bb33bb000080000000000000008e000000e800000000000000000000000000000000000000000000000000000000000000000000000000000000000
003bb300003bb3000008e800088e8000000e88800088e00000000000000000000000000000000000000000000000000000000000000000000000000000000000
003bb300003bb30000e88e0000e88e0000888e0000e8800000000000000000000000000000000000000000000000000000000000000000000000000000000000
0bb33bb00bb33bb0008e80000008e8800000e800008e000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0bb00bb000b00b000000800000000000000000000080000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00088000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00088000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
99900000000009997777777777777777777777777777777700000000000000000000000000000000000000000000000000000000000000000000000000000000
90000000000000097ffffff77ffffff77f7777f77ffffff700000000000000000000000000000000000000000000000000000000000000000000000000000000
90000000000000097ff77ff77f777ff77ffff7f77fff7ff700000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000007f7f7ff77ffff7f77ff777f77ff77ff700000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000007fff7ff77ff77ff77ffff7f77f7777f700000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000007fff7ff77f7ffff77f7777f77fff7ff700000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000007ffffff77ff777f77ffffff77fff7ff700000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000007777777777777777777777777777777700000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
90000000000000090000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
90000000000000090000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
99900000000009990000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
99000099000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
90000009000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
90000009000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
99000099000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
dddddddddddddddd0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
ddccdd7777ddccdd0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
dccc7cccccc7cccd0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
dcc7cccccccc7ccd0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
dd7cccc77cccc7dd0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
ddccc799997cccdd0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
d7ccc99aa99ccc7d0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
d7cc79aaaa97cc7d0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
d7cc79aaaa97cc7d0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
d7ccc99aa99ccc7d0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
ddccc799997cccdd0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
dd7cccc77cccc7dd0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
dcc7cccccccc7ccd0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
dccc7cccccc7cccd0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
ddccdd7777ddccdd0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
dddddddddddddddd0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
__label__
11111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
11cc1ccc11cc1c1c111117771777177717771111111cc11ccc1c1c1ccc1111111811111bb11bb11111111111111111111111c111ccc1ccc1ccc1111177717771
1c111c1c1c111c1c11c117171717171717171111111c1c1c111c1c11c111c11118e8111bb33bb11111111111111111111111c1111c11c111c1111c1111717171
1c111ccc1ccc1ccc111117771777177717771111111c1c1cc111c111c1111111e88e11113bb3111111111111111111111111c1111c11cc11cc11111177717171
1c111c1c111c1c1c11c111171117111711171111111c1c1c111c1c11c111c1118e8111113bb3111111111111111111111111c1111c11c111c1111c1171117171
11cc1c1c1cc11c1c111111171117111711171111111c1c1ccc1c1c11c11111111181111bb33bb11111111111111111111111ccc1ccc1c111ccc1111177717771
11111111111111111111111111111111111111111111111111111111111111111111111bb11bb111111111111111111111111111111111111111111111111111
11111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
66666666666666666666666666666666666666666666666666666666666666666666666666666666666666666666666666666666666666666666666666666666
6dddddddddddddddddddddddddddddddddccdd7777ddccddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddd6
6ddddddddddddddddddddddddddddddddccc7cccccc7cccdddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddd6
6ddcdddddddcdddddddcdddddddcdddddcc7cccccccc7ccdddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddd6
6dddcdddddddcdddddddcdddddddcddddd7cccc77cccc7ddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddd6
6dddddddddddddddddddddddddddddddddccc799997cccddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddd6
6dddddddddddddddddddddddddddddddd7ccc99aa99ccc7dddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddd6
6dddddddddddddddddddddddddddddddd7cc79aaaa97cc7dddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddd6
6dddddddddddddddddddddddddddddddd7cc79aaaa97cc7dddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddd6
6dddddddddccdd7777ddccddddddddddd7ccc99aa99ccc7dddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddd6
6ddddddddccc7cccccc7cccdddddddddddccc799997cccddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddd6
6ddcdddddcc7cccccccc7ccddddcdddddd7cccc77cccc7ddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddd6
6dddcddddd7cccc77cccc7ddddddcddddcc7cccccccc7ccdddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddd6
6dddddddddccc799997cccdddddddddddccc7cccccc7cccdddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddd6
6dddddddd7ccc99aa99ccc7dddddddddddccdd7777ddccddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddd6
6dddddddd7cc79aaaa97cc7dddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddd6
6dddddddd7cc79aaaa97cc7dddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddd6
6dddddddd7ccc99aa99ccc7dddddddddddccdd7777ddccddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddd6
6dddddddddccc799997cccdddddddddddccc7cccccc7cccdddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddd6
6ddcdddddd7cccc77cccc7dddddcdddddcc7cccccccc7ccdddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddd6
6dddcddddcc7cccccccc7ccdddddcddddd7cccc77cccc7ddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddd6
6ddddddddccc7cccccc7cccdddddddddddccc799997cccddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddd6
6dddddddddccdd7777ddccddddddddddd7ccc99aa99ccc7dddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddd6
6dddddddddddddddddddddddddddddddd7cc79aaaa97cc7dddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddd6
6dddddddddddddddddddddddddddddddd7cc79aaaa97cc7dddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddd6
6dddddddddccdd7777ddccddddddddddd7ccc99aa99ccc7dddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddd6
6ddddddddccc7cccccc7cccdddddddddddccc799997cccddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddd6
6ddcdddddcc7cccccccc7ccddddcdddddd7cccc77cccc7ddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddd6
6dddcddddd7cccc77cccc7ddddddcddddcc7cccccccc7ccdddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddd6
6dddddddddccc799997cccdddddddddddccc7cccccc7cccdddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddd6
6dddddddd7ccc99aa99ccc7dddddddddddccdd7777ddccddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddd6
6dddddddd7cc79aaaa97cc7dddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddd6
6dddddddd7cc79aaaa97cc7dddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddd6
6dddddddd7ccc99aa99ccc7dddddddddddddddddddddddddddccdd7777ddccddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddd6
6dddddddddccc799997cccdddddddddddddddddddddddddddccc7cccccc7cccdddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddd6
6ddcdddddd7cccc77cccc7dddddcdddddddcdddddddcdddddcc7cccccccc7ccdddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddd6
6dddcddddcc7cccccccc7ccdddddcdddddddcdddddddcddddd7cccc77cccc7ddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddd6
6ddddddddccc7cccccc7cccdddddddddddddddddddddddddddccc799997cccddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddd6
6dddddddddccdd7777ddccddddddddddddddddddddddddddd7ccc99aa99ccc7dddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddd6
6dddddddddddddddddddddddddddddddddddddddddddddddd7cc79aaaa97cc7dddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddd6
6dddddddddddddddddddddddddddddddddddddddddddddddd7cc79aaaa97cc7dddddd5555555ddddddddddddddddddddddddddddddddddddddddddddddddddd6
6dddddddddccdd7777ddccddddddddddddddddddddddddddd7ccc99aa99ccc7ddd555ddddddd555dddddddddddddddddddddddddddddddddddddddddddddddd6
6ddddddddccc7cccccc7cccdddddddddddddddddddddddddddccc799997cccdd55ddddddddddddd55dddddddddddddddddddddddddddddddddddddddddddddd6
6ddcdddddcc7cccccccc7ccddddddddddddddddddddcdddddd7cccc77cccc7d5ddddddddddddddddd5ddddddddddddddddddddddddddddddddddddddddddddd6
6dddcddddd7cccc77cccc7ddddddddddddddddddddddcddddcc7cccccccc755ddddddddddddddddddd55ddddddddddddddddddddddddddddddddddddddddddd6
6dddddddddccc799997cccdddddddddddddddddddddddddddccc7cccccc75ccddddddddddddddddddddd5dddddddddddddddddddddddddddddddddddddddddd6
6dddddddd7ccc99aa99ccc7dddddddddddddddddddddddddddccdd7777dd5cdddddddddddddddddddddd5dddddddddddddddddddddddddddddddddddddddddd6
6dddddddd7cc79aaaa97cc7dddddddddddddddddddddddddddddddddddd5ddddddddddddddddddddddddd5ddddddddddddddddddddddddddddddddddddddddd6
68888888d7cc79aaaa97cc7ddddddddddddddddddddccc888dddccc8885ddddd99ddddd99ddddd99dddddd5dddddddddddddddddddddddddddddddddddddddd6
62222228d7ccc99aa99ccc7ddddddddddddddddddddbbddbbdddbbddbb5ddddd9dccdd7777ddccd9dddddd5dddddddddddddddddddddddddddddddddddddddd6
62111128ddccc799997cccdddddddddddddddddddddbb33bbdddbb33bbdddddddccc7cccccc7cccdddddddd5ddddddddddddddddddddddddddddddddddddddd6
621c0128dd7cccc77cccc7dddddddddddddddddddddc3bb3dddcd3bb35dcdddddcc7cccccccc7ccdddddddd5ddddddddddddddddddddddddddddddddddddddd6
6210c128dcc7cccccccc7ccddddddddddddddddddddd3bb3ddddc3bb3cccc88ddd7cccc77cccc7ddddddddd5ddddddddddddddddddddddddddddddddddddddd6
62111128dccc7cccccc7cccddddddddddddddddddddbb33bbdddbb33bbbddbbdddccc799997cccdddddddddd5dddddddddddddddddddddddddddddddddddddd6
62222228ddccdd7777ddccdddddddddddddddddddddbbddbbdddbbddbbb33bbdd7ccc99aa99ccc7ddddddddd5dddddddddddddddddddddddddddddddddddddd6
68888888dddddddddddddddddddddddddddddddddddddddddddddddd5d3bb3dd97cc79aaaa97cc79dddddddd5dddddddddddddddddddddddddddddddddddddd6
6ddddddddddddddddddddddddddddddddddddddddddddddddddddddd5d3bb3dd97cc79aaaa97cc79dddddddd5dddddddddddddddddddddddddddddddbbbbbbb6
6dccdd7777ddccdddddddddddddddddddddddddddddddddddddddddd5bb33bbdd7ccc99aa99ccc7ddddddddd5dddddddddddddddddddddddddddddddb3333336
6ccc7cccccc7cccddddddddddddddddddddddddddddddddddddddddd5bbddbbdddccc799997cccdddddddddd5dddddddddddddddddddddddddddddddb3111136
6cc7cccccccc7ccddddddddddddddddddddddddddddddddddddddddd5ddcdddddd7cccc77cccc7dddddddddd5dddddddddddddddddddddddddddddddb31c0136
6d7cccc77cccc7ddddddddddddddddddddddddddddddddddddddddddd5ddcddddcc7cccccccc7ccdddddddd5ddddddddddddddddddddddddddddddddb310c136
6dccc799997cccddddddddddddddddddddddddddddddddddddddddddd5dddddddccc7cccccc7cccdddddddd5ddddddddddddddddddddddddddddddddb3111136
67ccc99aa99ccc7dddddddddddddddddddddddddddddddddddddddddd5dddddd9dccdd7777ddccd9ddddddd5ddddddddddddddddddddddddddddddddb3333336
67cc79aaaa97cc7ddddddddddddddddddddddddddddddddddddddddddd5ddddd99ddddd99ddddd99dddddd5dddddddddddddddddddddddddddddddddbbbbbbb6
67cc79aaaa97cc7ddddddddddddddddddddddddddddddddddddddddddd5ddddddddddddddddddddddddddd5dddddddddddddddddddddddddddddddddddddddd6
67ccc99aa99ccc7dddddddddddddddddddddddddddddddddddddddddddd5ddddddddddddddddddddddccd57777ddccddddddddddddddddddddddddddddddddd6
6dccc799997cccdddddddddddddddddddddddddddddddddddddddddddddd5ddddddddddddddddddddccc5cccccc7cccdddddddddddddddddddddddddddddddd6
6d7cccc77cccc7dddddddddddddddddddddddddddddddddddddddddddddc5ddddddcdddddddcdddddcc75ccccccc7ccddddddddddddddddddddcdddddddcddd6
6cc7cccccccc7ccdddddddddddddddddddddddddddddddddddddddddddddc55dddddcdddddddcddddd55ccc77cccc7ddddddddddddddddddddddcdddddddcdd6
6ccc7cccccc7cccdddddddddddddddddddddddddddddddddddddddddddddddd5ddddddddddddddddd5ccc799997cccdddddddddddddddddddccc888dddddddd6
6dccdd7777ddccdddddddddddddddddddddddddddddddddddddddddddddddddd55ddddddddddddd557ccc99aa99ccc7ddddddddddddddddddbbddbbdddddddd6
6ddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddd555ddddddd555dd7cc79aaaa97cc7ddddddddddddddddddbb33bbdddddddd6
6dddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddd5555555ddddd7cc79aaaa97cc7ddddddddddddccc888d3bb3ddddddddd6
6dddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddd7ccc99aa99ccc7ddddddddddddbbddbbd3bb3ddddddddd6
6dddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddccc799997cccdddddddddddddbb33bbbb33bbdddddddd6
6ddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddcdddddd7cccc77cccc7dddddddddddddc3bb3dbbcdbbdddddddd6
6dddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddcddddcc7cccccccc7ccddddddddddddd3bb3ddddcdddddddddd6
6ddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddcccc88ddccc7cccccc7cccddddddddddddbb33bbdddddddddddddd6
6dddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddd8ddddddccdd7777ddccdddddddddddddbbddbbdddddddddddddd6
6dddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddd8e8dddddddddddddddddddddddddddcccc88dddddddddddddddd6
6ddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddde88eddddddddddccccccdddc88888ddbbddbbdddddddddddddddd6
6ddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddd8e8ddddddddddddd8dddddddd8dddddbb33bbdddddddddddddddd6
6ddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddd8ddddddddddddd8e8dddddd8e8dddd3bb3ddddddddddddddddd6
6ddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddcdddddddcddddde88eddddde88edddd3bb3ddddddddddddddddd6
6dddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddcdddddddcdddd8e8cddddd8e8ddddbb33bbdddddddddddddddd6
6dddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddd8dddddddd8ddddbbddbbdddddddddddddddd6
6dddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddd6
6dddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddd6
6dddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddd6
6dddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddd6
6dddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddd6
6dddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddd6
6dddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddd6
6dddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddd6
6dddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddd6
6dddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddd6
6dddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddd6
6dddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddd6
6dddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddd6
6dddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddd6
6dddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddd6
6dddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddd6
6dddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddd6
6dddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddd6
6dddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddd6
6dddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddd6
6dddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddd6
6dddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddd6
6dddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddd6
6dddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddd6
6dddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddd6
6dddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddd6
6dddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddd6
6daaddaaadaaaddddaaadaaadadadaaadddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddaaadaaad6
6ddaddddadadadddddaddadadadadadddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddadadad6
6ddaddaaadaaadddddaddaaddadadaadddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddaadadad6
6ddaddadddadadddddaddadadadadadddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddadadad6
6daaadaaadaaadddddaddadaddaadaaadddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddaaadaaad6
6dddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddd6
66666666666666666666666666666666666666666666666666666666666666666666666666666666666666666666666666666666666666666666666666666666

__gff__
0000000000000000000100000000000000408000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0101000000000000000000000000000001010000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
__map__
0909090909090909090909090909090909090909090909090909090909090909090909090909090909090909090909090000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0701010101010101010101010101010807010101010101010101010101010108070101010101010101010101010101080000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
020a0a0a0a0a0a0a0a0a0a0a0a0a0a04020a0a0a0a0a0a0a0a0a0a0a0a0a0a04020a0a0a0a0a0a0a0a0a0a0a0a0a0a040000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
020a0a0a0a0a0a0a0a0a0a0a0a0a0a04020a0a0a0a0a0a0a0a0a0a0a0a0a0a04020a0a0a0a0a0a0a0a0a0a0a0a0a0a040000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
020a0a0a0a0a0a0a0a0a0a0a0a0a0a04020a0a0a0a0a0a0a0a0a0a0a0a0a0a04020a0a0a0a0a0a0a0a0a09090a0a0a040000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
020a0a0a0a0a0a0a0a0a0a0a0a0a0a04020a0a0a0a0a0a0a0a0a0a0a0a0a0a04020a0a0a0a110a0a0a09090a0a0a0a040000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
020a0a0a0a0a0a0a0a0a0a0a0a0a0a04020a0a0a0a0a0a0a0a0a0a0a0a0a0a04020a0a0a0a0a0a0a0a090a0a0a0a0a040000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
110a0a0a0a0a0a0a0a0a0a0a0a0a0a04020a0a0a0a0a0a0a0a0a0a0a0a0a0a04020a0a0a0a0a0a0a09090a0a0a0a0a040000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
020a0a0a0a0a0a0a0a0a0a0a0a0a0a12020a0a0a0a0a0a0a0a0a0a0a0a0a0a04020a0a0a0a0a0a09090a0a0a0a0a0a040000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
020a0a0a0a0a0a0a0a0a0a0a0a0a0a04020a0a0a0a0a110a0a0a0a0a0a0a0a04020a0a0a0a0a09090a0a0a0a0a0a0a040000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
020a0a0a0a0a0a0a0a0a0a0a0a0a0a04020a0a0a0a0a0a0a0a0a0a0a0a0a0a04020a0a0a0a09090a0a120a0a0a0a0a040000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
020a0a0a0a0a0a0a0a0a0a0a0a0a0a04020a0a0a0a0a0a0a0a0a0a0a0a0a0a04020a0a0a09090a0a0a0a0a0a0a0a0a040000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
020a0a0a0a0a0a0a0a0a0a0a0a0a0a04020a0a0a0a0a0a0a0a0a0a0a120a0a04020a0a0a0a0a0a0a0a0a0a0a0a0a0a040000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
020a0a0a0a0a0a0a0a0a0a0a0a0a0a04020a0a0a0a0a0a0a0a0a0a0a0a0a0a04020a0a0a0a0a0a0a0a0a0a0a0a0a0a040000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
020a0a0a0a0a0a0a0a0a0a0a0a0a0a04020a0a0a0a0a0a0a0a0a0a0a0a0a0a04020a0a0a0a0a0a0a0a0a0a0a0a0a0a040000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0503030303030303030303030303030605030303030303030303030303030306050303030303030303030303030303060000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00010101000001000001000100010101000a000a000a000a000a00000a000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00010000000100010001010100010000000a000a000a000a000a0a000a000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00010000000100010001000100010000000a000a000a000a000a0a000a000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0001000100010101000100010001010000000a000a00000a000a000a0a000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0001000100010001000100010001000000000a000a00000a000a000a0a000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0001010100010001000100010001010100000a000a00000a000a00000a000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0001010100010001000101010001010100000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0001000100010001000100000001000100000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0001000100010001000100000001010100000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0001000100010001000101000001010000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0001000100010001000100000001000100000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0001010100000100000101010001000100000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
