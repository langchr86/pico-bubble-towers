#! /bin/sh

./export.sh

rm -f /x/web/fileshare/pico/*

pico8.exe releases/bubble-towers-xx.p8.png -export /x/web/fileshare/pico/bubble-towers.html

mv /x/web/fileshare/pico/bubble-towers.html /x/web/fileshare/pico/index.html


# manually change the index title
# Bubble Towers - PICO-8 Cartridge

# manually add the following at the end of the index.html
# <!-- Add content below the cart here -->
# <p# >BBS: <a href="https://www.lexaloffle.com/bbs/?tid=143267">lexaloffle.com/bbs/?tid=143267</a></p>
