#! /bin/sh

./export.sh

rm -f /x/web/fileshare/pico/*

pico8.exe releases/bubble-towers-xx.p8.png -export /x/web/fileshare/pico/bubble-towers.html

mv /x/web/fileshare/pico/bubble-towers.html /x/web/fileshare/pico/index.html
