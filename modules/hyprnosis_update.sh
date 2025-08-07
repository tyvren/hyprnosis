#!/bin/bash

MENU=$(printf "Update hyprnosis" | wofi --dmenu --width 300 --height 200 --cache-file /dev/null --prompt "Select an option")
[[ -z "$MENU" ]] && exit 0

INSTALL_DIR="$HOME/.config/hyprnosis"
BRANCH="main"

git -C "$INSTALL_DIR" fetch origin
git -C "$INSTALL_DIR" reset --hard origin/$BRANCH
notify-send "Updated hyprnosis"
