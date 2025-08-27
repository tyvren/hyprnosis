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

cp -r "$THEME_PATH/nvim/lua/plugins/colorscheme.lua" "$HOME/.config/nvim/lua/plugins"
cp -r "$THEME_PATH/"* "$HOME/.config/"

if [[ -n "$SELECTED_THEME" ]]; then
  sed -i "s/^theme = \".*\"/theme = \"$SELECTED_THEME\"/" ~/.config/walker/config.toml
  walker --reload 
fi

if command -v hyprctl &> /dev/null; then
  echo "Reloading Hyprland config..."
  hyprctl reload
fi

echo "Reloading Waybar..."
killall waybar 2>/dev/null || true
if command -v waybar &> /dev/null; then
  nohup waybar > /dev/null 2>&1 &
fi

echo "Reloading Hyprpaper..."
killall hyprpaper 2>/dev/null || true
if command -v hyprpaper &> /dev/null; then
  nohup hyprpaper > /dev/null 2>&1 &
fi

notify-send "Theme Changed" "Theme '$SELECTED_THEME' applied."

