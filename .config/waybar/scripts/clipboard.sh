#!/bin/bash

# جلب قائمة العناصر من cliphist وتمريرها لـ rofi للبحث
case "$1" in
    d) # للعرض والاختيار
        #cliphist list | rofi -dmenu -p "󰅌 Clipboard" -theme ~/.config/rofi/clipboard.rasi | cliphist decode | wl-copy
# أضفنا امر 'cut' لحذف الرقم والمعرف في بداية كل سطر
cliphist list | cut -d' ' -f2- | rofi -dmenu -p "󰅌" -theme ~/.config/rofi/clipboard.rasi | cliphist decode | wl-copy        
;;
    w) # للمسح (Wipe)
        cliphist wipe
        ;;
esac
