#!/bin/bash
# Wähle Monitorposition mit rofi

selected_option=$(echo -e "right\nleft\nup\nHDMI_only" | rofi -dmenu -i -p "Position des HDMI Monitors")

# Prüfen, ob HDMI-A-0 verbunden ist
if ! xrandr | grep -q "HDMI-A-0 connected"; then
    notify-send "Fehler" "HDMI-A-0 ist nicht verbunden!"
    exit 1
fi

xrandr --auto  # Stellt sicher, dass alle Monitore erkannt werden

change_applied=false  # Flag, um zu prüfen, ob sich etwas geändert hat

case $selected_option in
    right)
        xrandr --output eDP --left-of HDMI-A-0 --auto
        change_applied=true
        ;;
    left)
        xrandr --output eDP --right-of HDMI-A-0 --auto
        change_applied=true
        ;;
    up)
        xrandr --output eDP --below HDMI-A-0 --auto
        change_applied=true
        ;;
    HDMI_only)
        xrandr --output eDP --off --output HDMI-A-0 --primary --auto
        change_applied=true
        ;;
    *)
        exit 0  # Falls keine Auswahl getroffen wurde, abbrechen
        ;;
esac

# Warte 1 Sekunde, damit xrandr die Änderungen sauber verarbeitet
if [ "$change_applied" = true ]; then
    sleep 1
    i3-msg restart
fi
