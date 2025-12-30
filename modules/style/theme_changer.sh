#!/bin/bash

THEME_DIR="$HOME/.config/hyprnosis/themes"
WALLPAPER_DIR="$HOME/.config/hyprnosis/wallpapers"
QUICKSHELL_CONF="$HOME/.config/quickshell/Theme.qml"

if [[ -z "$1" ]]; then
  echo "Usage: $0 <theme_name>"
  exit 1
fi

SELECTED_THEME="$1"
THEME_PATH="$THEME_DIR/$SELECTED_THEME"
WALL_PATH="$WALLPAPER_DIR/$SELECTED_THEME"

if [[ ! -d "$THEME_PATH" ]]; then
  echo "Theme '$SELECTED_THEME' does not exist in $THEME_DIR"
  exit 1
fi

shopt -s nullglob
WALLPAPERS=("$WALL_PATH"/*.png "$WALL_PATH"/*.jpg)
if ((${#WALLPAPERS[@]} == 0)); then
  echo "No wallpapers found in $WALL_PATH"
  exit 1
fi
WALL_PATH="${WALLPAPERS[0]}"

cp -r "$THEME_PATH/"* "$HOME/.config/"

sed -i -r "s|property string wallpaperPath: \".*\"|property string wallpaperPath: \"${WALL_PATH}\"|" "$QUICKSHELL_CONF"

sed -i -r "s|property string wallpaperDir: \".*\"|property string wallpaperDir: \"${HOME}/.config/hyprnosis/wallpapers/$SELECTED_THEME\"|" \
  "$HOME/.config/quickshell/Modules/Menus/Wallpapers.qml"

if [ "$SELECTED_THEME" = "Dracula" ]; then
  gsettings set org.gnome.desktop.interface gtk-theme 'Dracula'
  gsettings set org.gnome.desktop.interface icon-theme 'Tela-circle-dracula'
else
  gsettings set org.gnome.desktop.interface icon-theme 'Tela-circle-black'
fi

notify-send "Theme Changed" "Theme '$SELECTED_THEME' applied."
