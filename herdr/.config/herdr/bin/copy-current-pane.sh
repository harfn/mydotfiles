#!/usr/bin/env bash

set -euo pipefail

pane_id="$(
  herdr pane current --current \
    | jq -r '.result.pane.pane_id'
)"

if [ -z "$pane_id" ] || [ "$pane_id" = "null" ]; then
  herdr notification show "Herdr pane copy failed" \
    --body "Konnte keine aktuelle Pane-ID lesen." \
    --position top-right \
    --sound request
  exit 1
fi

printf '%s' "$pane_id" | xclip -selection clipboard

herdr notification show "Pane ID copied" \
  --body "$pane_id" \
  --position top-right \
  --sound done
