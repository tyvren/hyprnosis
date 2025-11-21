#!/bin/bash

THEME_DIR="$HOME/.config/hyprnosis/themes"

menu() {
  local prompt="$1"
  local options="$2"
  echo -e "$options" | walker --dmenu -H -p "$prompt…"
}

mapfile -t THEMES < <(ls -1 "$THEME_DIR")
theme_list=$(printf "%s\n" "${THEMES[@]}")

THEME_MENU=$(menu "Select a theme" "$theme_list")
[[ -z "$THEME_MENU" ]] && exit 0

SELECTED_THEME="$THEME_MENU"
THEME_PATH="$THEME_DIR/$SELECTED_THEME"

cp -r "$THEME_PATH/"* "$HOME/.config/"

if [[ -n "$SELECTED_THEME" ]]; then
  sed -i -r "s|WALLPAPER_DIR=.*|WALLPAPER_DIR=\"$HOME/.config/hyprnosis/wallpapers/$SELECTED_THEME/\"|" ~/.config/hyprnosis/modules/style/randomize_wallpaper.sh
  sed -i "s/^theme = \".*\"/theme = \"$SELECTED_THEME\"/" ~/.config/walker/config.toml
  walker --reload
  if [ "$SELECTED_THEME" = "Dracula" ]; then
    gsettings set org.gnome.desktop.interface gtk-theme 'Dracula'
    gsettings set org.gnome.desktop.interface icon-theme 'Tela-circle-dracula'
  elif [ "$SELECTED_THEME" = "Nord" ]; then
    gsettings set org.gnome.desktop.interface icon-theme 'Tela-circle-nord'
  else
    gsettings set org.gnome.desktop.interface icon-theme 'Tela-circle-black'
  fi
fi

hyprctl reload
killall hyprpaper waybar walker
systemctl --user restart hyprpaper.service waybar.service walker.service

notify-send "Theme Changed" "Theme '$SELECTED_THEME' applied."
