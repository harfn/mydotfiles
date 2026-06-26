#!/bin/bash

ex_screen="DP-1"        # extern, z.B. DP-1 oder HDMI-1
internal_screen="eDP-1" # intern, oft eDP-1 (bitte mit `xrandr` prüfen)

selected_option=$(printf "right\nleft\nup\nHDMI_only\n" | rofi -dmenu -i -p "Position des HDMI Monitors")

# Prüfen, ob $ex_screen verbunden ist
if ! xrandr | grep -q "^$ex_screen connected"; then
  notify-send "Fehler" "$ex_screen ist nicht verbunden!"
  exit 1
fi

change_applied=false

case "$selected_option" in
  right)
    xrandr --output "$internal_screen" --left-of "$ex_screen" --auto \
           --output "$ex_screen" --auto
    change_applied=true
    ;;
  left)
    xrandr --output "$internal_screen" --right-of "$ex_screen" --auto \
           --output "$ex_screen" --auto
    change_applied=true
    ;;
  up)
    xrandr --output "$internal_screen" --below "$ex_screen" --auto \
           --output "$ex_screen" --auto
    change_applied=true
    ;;
  HDMI_only)
    xrandr --output "$internal_screen" --off \
           --output "$ex_screen" --primary --auto
    change_applied=true
    ;;
  *)
    exit 0
    ;;
esac

if [ "$change_applied" = true ]; then
  sleep 1
  i3-msg restart
fi
