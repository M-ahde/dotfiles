#!/bin/bash

# توليد النص (تأكد من تثبيت figlet)
# خيار -f small يجعل النص متوافق مع حجم النافذة
title=$(figlet -f big "POWER")

options="  Shutdown\n󰜉  Reboot\n󰗼  Logout\n  Lock"

chosen=$(echo -e "$options" | rofi -dmenu -mesg "$title" -theme ~/.config/rofi/powermenu.rasi)

case $chosen in
    "  Shutdown") systemctl poweroff ;;
    "󰜉  Reboot") systemctl reboot ;;
    "󰗼  Logout") hyprctl dispatch exit ;;
    "  Lock") hyprlock ;;
esac
