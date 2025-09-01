#!/bin/bash

clear

gum style --foreground 212 --border double --padding "1 3" --margin "1 0" 'hyprnosis'

CHOICE=$(gum choose --cursor.bold "Update system" "Update hyprnosis" "Exit")

case "$CHOICE" in
  "Update system")
    clear
    gum style --foreground 99 --border double --padding "1 3" "System Update (interactive)"
    yay -Syu
    gum confirm "Done. Press Enter to return to menu." && exec "$0"
    ;;

  "Update hyprnosis")
    INSTALL_DIR="$HOME/.config/hyprnosis"
    BRANCH="main"
    
    gum style --foreground 212 "Updating Hyprnosis..."

    git -C "$INSTALL_DIR" fetch origin
    git -C "$INSTALL_DIR" reset --hard origin/$BRANCH
    git clone --depth 1 https://github.com/steve-conrad/hyprnosis-wallpapers.git /tmp/wallpapers && \
    cp -r /tmp/wallpapers/. "$INSTALL_DIR/wallpapers/" && \
    rm -rf /tmp/wallpapers
    cp -r "$INSTALL_DIR/themes/Hyprnosis/." "$HOME/.config/"
    cp -r "$HOME/.config/hyprnosis/config/"* "$HOME/.config/"

    gum confirm "Hyprnosis updated. Press Enter to return to menu." && exec "$0"
    ;;

  "Exit")
    clear
    exit 0
    ;;
esac

