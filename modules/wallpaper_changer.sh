#!/usr/bin/env bash
clear

WALLPAPER_DIR="$HOME/.config/hyprnosis/wallpapers"
HYPRPAPER_CONF="$HOME/.config/hypr/hyprpaper.conf"
HYPRLOCK_CONF="$HOME/.config/hypr/hyprlock.conf"

menu() {
    local prompt="$1"
    local options="$2"
    echo -e "$options" | walker --dmenu -H -p "$prompt…"
}

mapfile -t THEMES < <(find "$WALLPAPER_DIR" -mindepth 1 -maxdepth 1 -type d -printf "%f\n")
theme_list=$(printf "%s\n" "${THEMES[@]}")

SELECTED_THEME=$(menu "Select a theme to view wallpaper options" "$theme_list")
[[ -z "$SELECTED_THEME" ]] && exit 0

THEME_PATH="$WALLPAPER_DIR/$SELECTED_THEME"
mapfile -t WALLPAPERS < <(find "$THEME_PATH" -type f -printf "%f\n")
wallpaper_list=$(printf "%s\n" "${WALLPAPERS[@]}")

SELECTED_WALLPAPER=$(menu "Select a wallpaper" "$wallpaper_list")
[[ -z "$SELECTED_WALLPAPER" ]] && exit 0

WALLPAPER_PATH="$THEME_PATH/$SELECTED_WALLPAPER"

killall hyprpaper 2>/dev/null || true
if command -v hyprpaper &> /dev/null; then
  nohup hyprpaper > /dev/null 2>&1 &
fi

sed -i "s|^preload = .*|preload = $WALLPAPER_PATH|" "$HYPRPAPER_CONF"
sed -i "s|^wallpaper = .*|wallpaper = ,$WALLPAPER_PATH|" "$HYPRPAPER_CONF"
sed -i "/background {/,/}/{s|^\s*path = .*|  path = $WALLPAPER_PATH|}" "$HYPRLOCK_CONF"

notify-send "Wallpaper Changed" "Wallpaper '$SELECTED_WALLPAPER' applied."
