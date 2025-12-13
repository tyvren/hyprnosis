#!/bin/bash

THEME_DIR="$HOME/.config/hyprnosis/themes"

if [[ -z "$1" ]]; then
  echo "Usage: $0 <theme_name>"
  exit 1
fi

SELECTED_THEME="$1"
THEME_PATH="$THEME_DIR/$SELECTED_THEME"

if [[ ! -d "$THEME_PATH" ]]; then
  echo "Theme '$SELECTED_THEME' does not exist in $THEME_DIR"
  exit 1
fi

cp -r "$THEME_PATH/"* "$HOME/.config/"

sed -i -r "s|WALLPAPER_DIR=.*|WALLPAPER_DIR=\"$HOME/.config/hyprnosis/wallpapers/$SELECTED_THEME/\"|" "$HOME/.config/hyprnosis/modules/style/randomize_wallpaper.sh"

if [ "$SELECTED_THEME" = "Dracula" ]; then
  gsettings set org.gnome.desktop.interface gtk-theme 'Dracula'
  gsettings set org.gnome.desktop.interface icon-theme 'Tela-circle-dracula'
else
  gsettings set org.gnome.desktop.interface icon-theme 'Tela-circle-black'
fi

sed -i -r "s|property string wallpaperDir: \".*\"|property string wallpaperDir: \"${HOME}/.config/hyprnosis/wallpapers/$SELECTED_THEME\"|" \
  "$HOME/.config/quickshell/Modules/Menus/Wallpapers.qml"

notify-send "Theme Changed" "Theme '$SELECTED_THEME' applied."
hyprctl reload
killall hyprpaper 2>/dev/null || true
systemctl --user restart hyprpaper.service
