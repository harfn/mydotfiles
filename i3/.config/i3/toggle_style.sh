#!/bin/bash

# Datei zum Speichern des aktuellen Themas
THEME_STATUS_FILE="$HOME/.config/current_theme"

# Pfad zum aktuellen Hintergrundbild
BACKGROUND_DIR="$HOME/Pictures/Backgrounds"
LIGHT_BACKGROUND="$BACKGROUND_DIR/rebel-light.jpg"
DARK_BACKGROUND="$BACKGROUND_DIR/rebel-dark.jpg"

# Farbschema-Dateien
#I3_CONFIG_LIGHT="$HOME/.config/i3/config_light"
#I3_CONFIG_DARK="$HOME/.config/i3/config_dark"

# Überprüfen des aktuellen Themas
if [ -f "$THEME_STATUS_FILE" ]; then
    CURRENT_THEME=$(cat "$THEME_STATUS_FILE")
else
    # Standardmäßig auf Light Mode setzen, wenn die Datei nicht existiert
    CURRENT_THEME="light"
    echo $CURRENT_THEME > "$THEME_STATUS_FILE"
fi

if [ "$CURRENT_THEME" = "dark" ]; then
    # Wechsel zum Light Mode
    cp  ~/.config/wezterm/color-light.lua ~/.config/wezterm/colors.lua --update=all
    feh --bg-center --image-bg "#CBBFAE" $LIGHT_BACKGROUND
    echo "light" > "$THEME_STATUS_FILE"
else
    # Wechsel zum Dark Mode
    cp  ~/.config/wezterm/color-dark.lua ~/.config/wezterm/colors.lua --update=all
    feh --bg-center --image-bg "#242424" $DARK_BACKGROUND
    echo "dark" > "$THEME_STATUS_FILE"
fi

# i3 neu laden
#i3-msg reload
#i3-msg restart

# Optional: Benachrichtigung
notify-send "Theme switched to $(cat $THEME_STATUS_FILE) mode"

