#!/usr/bin/env bash
set -euo pipefail

# Default-Interface (IPv4) ermitteln
IFACE="$(ip -4 route show default 2>/dev/null | awk 'NR==1{print $5}')"

if [[ -z "${IFACE:-}" ]]; then
  echo "󰤭 no route"
  exit 0
fi

# Helper: WLAN-Qualität (0-70) -> Prozent
wifi_percent() {
  # /proc/net/wireless: quality ist die 3. Spalte (Link), meist 0..70
  awk -v dev="$1" '
    $1 ~ dev":" {
      gsub(/\./,"",$3);
      q=$3;
      if (q>70) q=70;
      printf "%d\n", int((q/70)*100);
      exit
    }' /proc/net/wireless 2>/dev/null || true
}

# Helper: Prozent -> Icon
wifi_icon() {
  local p="${1:-0}"
  if   (( p >= 75 )); then echo "󰤨"
  elif (( p >= 50 )); then echo "󰤥"
  elif (( p >= 25 )); then echo "󰤢"
  else echo "󰤟"
  fi
}

if [[ "$IFACE" == wl* || "$IFACE" == wlan* ]]; then
  SSID="$(iw dev "$IFACE" link 2>/dev/null | awk -F': ' '/SSID/ {print $2; exit}')"
  [[ -z "${SSID:-}" ]] && SSID="wifi"

  PCT="$(wifi_percent "$IFACE")"
  [[ -z "${PCT:-}" ]] && PCT=0

  ICON="$(wifi_icon "$PCT")"
  echo "${ICON}  ${SSID} ${PCT}%"
else
  echo "󰈀  wired"
fi
