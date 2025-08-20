#!/bin/bash

menu() {
    local prompt="$1"
    local options="$2"
    echo -e "$options" | walker --dmenu -H -p "$prompt…"
}

items="Update System\nUpdate Hyprnosis"

selection=$(menu "Update Menu" "$items")

case "$selection" in
    *System*) 
	ghostty -e bash -c "yay -Syu" ;;
    *Hyprnosis*)     
        ghostty -e bash -c '
            INSTALL_DIR="$HOME/.config/hyprnosis"
            BRANCH="main"

            git -C "$INSTALL_DIR" fetch origin
            git -C "$INSTALL_DIR" reset --hard origin/$BRANCH

            git clone --depth 1 https://github.com/steve-conrad/hyprnosis-wallpapers.git /tmp/wallpapers && \
            cp -r /tmp/wallpapers/. "$INSTALL_DIR/wallpapers/" && \
            rm -rf /tmp/wallpapers

            cp -r "$INSTALL_DIR/themes/Default/." "$HOME/.config/"
            cp -r "$INSTALL_DIR/config/hypr/." "$HOME/.config/hypr/"
            cp -r "$INSTALL_DIR/config/nvim/." "$HOME/.config/nvim/"

            echo "Hyprnosis updated. Press enter to close..."
            read
        '
esac

