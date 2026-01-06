#!/bin/bash

THEME_DIR="$HOME/.config/hyprnosis/themes"
WALLPAPER_DIR="$HOME/.config/hyprnosis/wallpapers"
HYPRLOCK_CONF="$HOME/.config/hypr/hyprlock.conf"
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

sed -i "/background {/,/}/{s|^\s*path = .*|  path = $WALLPAPER_PATH|}" "$HYPRLOCK_CONF"

sed -i -r "s|property string wallpaperPath: \".*\"|property string wallpaperPath: \"${WALL_PATH}\"|" "$QUICKSHELL_CONF"

sed -i -r "s|property string wallpaperDir: \".*\"|property string wallpaperDir: \"${HOME}/.config/hyprnosis/wallpapers/$SELECTED_THEME\"|" \
  "$HOME/.config/quickshell/Modules/Menus/Wallpapers.qml"

case "$SELECTED_THEME" in
"Hyprnosis")
  GTK="catppuccin-mocha-sapphire-standard+default"
  ICONS="Tela-circle-black"
  CURSOR="catppuccin-mocha-sapphire-cursors"
  ;;
"Mocha")
  GTK="catppuccin-mocha-lavender-standard+default"
  ICONS="Tela-circle-black"
  CURSOR="catppuccin-mocha-lavender-cursors"
  ;;
"Emberforge")
  GTK="catppuccin-mocha-orange-standard+default"
  ICONS="Tela-circle-black"
  CURSOR="catppuccin-mocha-orange-cursors"
  ;;
"Dracula")
  GTK="Dracula"
  ICONS="Tela-circle-dracula"
  CURSOR="catppuccin-mocha-green-cursors"
  ;;
"Arcadia")
  GTK="catppuccin-mocha-pink-standard+default"
  ICONS="Tela-circle-black"
  CURSOR="catppuccin-mocha-pink-cursors"
  ;;
"Eden")
  GTK="catppuccin-mocha-green-standard+default"
  ICONS="Tela-circle-black"
  CURSOR="catppuccin-mocha-dark-cursors"
  ;;
*)
  GTK="catppuccin-mocha-blue-standard+default"
  ICONS="Tela-circle-black"
  CURSOR="catppuccin-mocha-dark-cursors"
  ;;
esac

gsettings set org.gnome.desktop.interface gtk-theme "$GTK"
gsettings set org.gnome.desktop.interface icon-theme "$ICONS"
gsettings set org.gnome.desktop.interface cursor-theme "$CURSOR"
hyprctl setcursor "$CURSOR" 24

notify-send "Theme Changed" "Theme '$SELECTED_THEME' applied."
