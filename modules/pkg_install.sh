#!/bin/bash

set -e

pkg_names=$(pacman -Slq)

filter() {
  gum filter --no-limit --text.foreground="99" --placeholder="Search for an Arch pkg to install" \
    --match.foreground="69"
}

selection=$(echo "$pkg_names\n" | filter)

sudo -v
gum spin --spinner dot --title "Installing $selection..." -- sudo pacman -S $selection --noconfirm

gum confirm "$selection installed. Select yes to exit."
