#!/bin/bash

HYPR_CONF="$HOME/.config/hypr/hyprland.conf"

mapfile -t BINDINGS < <(
  grep -E '^bind\s*=' "$HYPR_CONF" | while IFS= read -r line; do
    stripped=$(echo "$line" | sed -E 's/^bind\s*=\s*//')
    key_combo=$(echo "$stripped" | cut -d',' -f1-2 | xargs)
    command=$(echo "$stripped" | cut -d',' -f3- | sed 's/ *#.*//' | sed 's/,$//' | xargs)
    echo "${key_combo} → ${command}"
  done
)

if [[ ${#BINDINGS[@]} -eq 0 ]]; then
  notify-send "No keybinds found in hyprland.conf"
  exit 1
fi

CHOICE=$(printf '%s\n' "${BINDINGS[@]}" | wofi -dmenu -i -p "Hyprland Keybinds:")

cmd=$(echo "$CHOICE" | sed 's/.*→ //')

if [[ $cmd == exec* ]]; then
  eval "$cmd"
elif [[ -n $cmd ]]; then
  hyprctl dispatch "$cmd"
fi

