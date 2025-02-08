#!/bin/bash

selected_option=$(echo -e "Shutdown\nLock\nLogout\nReboot" | rofi -dmenu -i -p "Power Menu")

case $selected_option in
    Shutdown)
        systemctl poweroff
        ;;
    Lock)
        i3lock --image ~/Pictures/Backgrounds/lock.png --scale

        ;;
    Logout)
        i3-msg exit
        ;;
    Reboot)
        systemctl reboot
        ;;
    *)
        ;;
esac

