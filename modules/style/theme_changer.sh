#!/bin/bash

THEME_DIR="$HOME/.config/hyprnosis/themes"
WALLPAPER_DIR="$HOME/.config/hyprnosis/wallpapers"

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

cp -r "$THEME_PATH/"* "$HOME/.config/"

notify-send "Theme Changed" "$SELECTED_THEME"
