#!/bin/bash

INSTALL_DIR="$HOME/.config/hyprnosis"
CONFIG_DIR="$HOME/.config/hyprnosis/config"
LOCAL_CONFIG="$HOME/.config"

clear

header() {
  gum style \
    --foreground 37 --border-foreground 69 --border double \
    --align center --width 50 --margin "1 0" --padding "0 2" \
    'hyprnosis update'
}

prompt() {
  local text="$1"
  gum style --foreground 69 "$1"
}

header

gum spin --spinner dot --title "Fetching updates for hyprnosis..." -- git -C "$INSTALL_DIR" fetch origin
gum spin --spinner dot --title "Resetting repo to main branch" -- git -C "$INSTALL_DIR" reset --hard origin/main

gum spin --spinner dot --title "Updating wallpapers..." -- git clone --depth 1 https://github.com/tyvren/hyprnosis-wallpapers.git /tmp/wallpapers
rm -rf /tmp/wallpapers/.git
cp -r /tmp/wallpapers/. "$INSTALL_DIR/wallpapers/"
rm -rf /tmp/wallpapers

prompt "Updating elephant/walker configs..."
rm -r $HOME/.config/walker
cp -ru $CONFIG_DIR/walker "$LOCAL_CONFIG"
cp -ru $CONFIG_DIR/elephant "$LOCAL_CONFIG"

gum confirm "Update complete. Press enter to close."
