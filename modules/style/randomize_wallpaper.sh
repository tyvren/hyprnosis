#!/usr/bin/env bash

# Wallpaper randomizer - SUPER+SHIFT+T - changes your wallpaper to another random one within the specific theme folder then applies to hyprpaper and hyprlock configs

WALLPAPER_DIR="$HOME/.config/hyprnosis/wallpapers/Hyprnosis/"
HYPRPAPER_CONF="$HOME/.config/hypr/hyprpaper.conf"
HYPRLOCK_CONF="$HOME/.config/hypr/hyprlock.conf"

CURRENT_WALL=$(hyprctl hyprpaper listloaded)

# Get a random wallpaper that is not the current one
WALLPAPER=$(find "$WALLPAPER_DIR" -type f ! -name "$(basename "$CURRENT_WALL")" | shuf -n 1)

# Apply the selected wallpaper
hyprctl hyprpaper reload ,"$WALLPAPER"

# Update Hyprpaper config
sed -i "s|^preload = .*|preload = $WALLPAPER|" "$HYPRPAPER_CONF"
sed -i "s|^wallpaper = .*|wallpaper = ,$WALLPAPER|" "$HYPRPAPER_CONF"

# Update Hyprlock config
sed -i "/background {/,/}/{s|^\s*path = .*|  path = $WALLPAPER|}" "$HYPRLOCK_CONF"
