#!/bin/bash
set -euo pipefail

WAYBAR_CONF="$HOME/.config/waybar/config.jsonc"

if ! lsmod | grep -q '^k10temp'; then
  sudo modprobe k10temp
fi

hwmon_path=""
for hw in /sys/class/hwmon/hwmon*; do
  if [[ -r "$hw/name" ]]; then
    name=$(< "$hw/name")
    if [[ "$name" == "k10temp" || "$name" == "coretemp" ]]; then
      hwmon_path="$hw"
      break
    fi
  fi
done

if [[ -z "$hwmon_path" ]]; then
  echo "Error: k10temp hwmon not found"
  exit 1
fi

full_path="${hwmon_path}/temp1_input"
echo "k10temp found at: $full_path"

sed -i.bak -E "s|^([[:space:]]*)//?[[:space:]]*(\"hwmon-path\"[[:space:]]*:[[:space:]]*\")[^\"]*(\")|\1\2${full_path}\3|" "$WAYBAR_CONF"

killall waybar 2>/dev/null || true
if command -v waybar &> /dev/null; then
  nohup waybar > /dev/null 2>&1 &
fi
