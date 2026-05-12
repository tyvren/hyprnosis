#!/bin/bash

THEME_DIR="$HOME/.config/hyprnosis/themes"
WALLPAPER_DIR="$HOME/.config/hyprnosis/wallpapers"
HYPRLOCK_CONF="$HOME/.config/hypr/hyprlock.conf"

if [[ -z "$1" ]]; then
  exit 1
fi

SELECTED_THEME="$1"
if [[ "$SELECTED_THEME" == "Catppuccin Mocha" ]]; then
  SELECTED_THEME="Mocha"
fi

THEME_PATH="$THEME_DIR/$SELECTED_THEME"
WALL_PATH="$WALLPAPER_DIR/$SELECTED_THEME"

if [[ ! -d "$THEME_PATH" ]]; then
  exit 1
fi

shopt -s nullglob
WALLPAPERS=("$WALL_PATH"/*.png "$WALL_PATH"/*.jpg)
if ((${#WALLPAPERS[@]} > 0)); then
  sed -i "/background {/,/}/{s|^\s*path = .*|  path = ${WALLPAPERS[0]}|}" "$HYPRLOCK_CONF"
fi

cp -r "$THEME_PATH/"* "$HOME/.config/"

notify-send "Theme Changed" "System theme '$SELECTED_THEME' applied."
