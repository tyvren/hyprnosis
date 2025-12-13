#!/usr/bin/env bash
clear

HYPRPAPER_CONF="$HOME/.config/hypr/hyprpaper.conf"
HYPRLOCK_CONF="$HOME/.config/hypr/hyprlock.conf"
WALLPAPER_PATH="$1"

killall hyprpaper 2>/dev/null || true
if command -v hyprpaper &>/dev/null; then
  nohup hyprpaper >/dev/null 2>&1 &
fi

# Update hyprpaper config
sed -i "s|^preload = .*|preload = $WALLPAPER_PATH|" "$HYPRPAPER_CONF"
sed -i "s|^wallpaper = .*|wallpaper = ,$WALLPAPER_PATH|" "$HYPRPAPER_CONF"

# Update hyprlock config
sed -i "/background {/,/}/{s|^\s*path = .*|  path = $WALLPAPER_PATH|}" "$HYPRLOCK_CONF"

notify-send "Wallpaper Changed" "Wallpaper applied: $(basename "$WALLPAPER_PATH")"
