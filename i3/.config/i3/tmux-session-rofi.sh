#!/usr/bin/env bash
#
# tmux-session-rofi.sh
# - startet tmux-server
# - restored Sitzungen via resurrect/continuum
# - listet Sessions + "new" + "clean" in Rofi
# - bei "new": fragt nach Namen und erstellt neue Session
# - bei "clean": listet vorhandene Sessions und killt ausgewählte

# Server (und ggf. dummy‑Session) nur starten, wenn noch keine Sessions existieren
if ! tmux ls &>/dev/null; then
  # detached Dummy‑Session
  tmux new-session -d -s dummy

  # Pfad zum tmux-resurrect restore‑Script
  RESURRECT="$HOME/.config/tmux/plugins/tmux-resurrect/scripts/restore.sh"
  if [ -x "$RESURRECT" ]; then
    tmux run-shell "$RESURRECT"
  fi

  # Dummy‑Session wieder entfernen
  tmux kill-session -t dummy
fi

# 3. Aktuelle Sessions einlesen
mapfile -t existing < <(tmux list-sessions -F '#S' 2>/dev/null)

# 4. Menu-Optionen definieren
options=("${existing[@]}" "new" "clean")

# 5. Rofi-Auswahl anzeigen
choice=$(printf '%s\n' "${options[@]}" | rofi -dmenu -i -p "tmux:")

SAVE="$HOME/.config/tmux/plugins/tmux-resurrect/scripts/save.sh"
# 6. Aktionen je nach Auswahl
case "$choice" in
  "" )
    # nichts gewählt
    exit 0
    ;;
  new )
    # Name für neue Session abfragen
    name=$(printf '' | rofi -dmenu -p "Neuer Session-Name:")
    if [ -z "$name" ]; then
      notify-send "tmux" "Kein Name eingegeben. Abbruch."
      exit 1
    fi
    exec tmux new-session -s "$name"
    ;;
  clean )
    # Session zum Löschen wählen
    del=$(printf '%s\n' "${existing[@]}" | rofi -dmenu -i -p "Session löschen:")
    if [ -z "$del" ]; then
      notify-send "tmux" "Keine Session ausgewählt. Abbruch."
      exit 1
    fi
    tmux kill-session -t "$del"
    notify-send "tmux" "Session '$del' gelöscht."
    tmux run-shell "$SAVE"
    exit 0
    ;;
  * )
    # an bestehende Session anhängen
    [ -n "$TMUX" ] && tmux detach-client
    exec tmux attach-session -t "$choice"
    ;;
esac

