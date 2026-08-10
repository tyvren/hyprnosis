#!/bin/bash

INSTALL_DIR="$HOME/.config/somnium"
CONFIG_DIR="$HOME/.config/somnium/config"
LOCAL_CONFIG="$HOME/.config"

clear

header() {
  gum style \
    --foreground 37 --border-foreground 69 --border double \
    --align center --width 50 --margin "1 0" --padding "0 2" \
    'somnium update'
}

spin() {
  gum spin --spinner dot --title "$1" -- "${@:2}"
}

prompt() {
  gum style --foreground 69 "$1"
}

header

spin "Fetching updates for somnium" git -C "$INSTALL_DIR" fetch origin
spin "Resetting repo to main branch" git -C "$INSTALL_DIR" reset --hard origin/main

prompt "Updating Quickshell"
cp -r "$CONFIG_DIR/quickshell" "$LOCAL_CONFIG"

if gum confirm "Update somnium wallpapers?"; then
  spin "Updating wallpapers" git clone --depth 1 https://github.com/tyvren/somnium-wallpapers.git /tmp/wallpapers
  rm -rf /tmp/wallpapers/.git
  rm -rf /tmp/wallpapers/README.md
  cp -r /tmp/wallpapers/. "$INSTALL_DIR/wallpapers/"
  rm -rf /tmp/wallpapers
else
  gum confirm "Update complete. Press enter to close."
fi
