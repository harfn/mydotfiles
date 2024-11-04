#!/bin/bash

selected_option=$(echo -e "Logout\nReboot\nShutdown" | rofi -dmenu -i -p "Power Menu")

case $selected_option in
    Logout)
        i3-msg exit
        ;;
    Reboot)
        systemctl reboot
        ;;
    Shutdown)
        systemctl poweroff
        ;;
    *)
        ;;
esac

