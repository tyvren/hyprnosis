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

spin() {
  gum spin --spinner dot --title "$1" -- "${@:2}"
}

prompt() {
  gum style --foreground 69 "$1"
}

header

spin "Fetching updates for hyprnosis" git -C "$INSTALL_DIR" fetch origin
spin "Resetting repo to main branch" git -C "$INSTALL_DIR" reset --hard origin/main

spin "Updating wallpapers" git clone --depth 1 https://github.com/tyvren/hyprnosis-wallpapers.git /tmp/wallpapers
rm -rf /tmp/wallpapers/.git
rm -rf /tmp/wallpapers/README.md
cp -r /tmp/wallpapers/. "$INSTALL_DIR/wallpapers/"
rm -rf /tmp/wallpapers

prompt "Updating Quickshell config"
cp -r "$CONFIG_DIR/quickshell" "$LOCAL_CONFIG"

gum confirm "Update complete. Press enter to close."

pkill walker
systemctl --user restart walker.service elephant.service
