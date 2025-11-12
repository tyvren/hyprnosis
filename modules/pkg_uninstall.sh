#!/bin/bash

set -e

pkg_names=$(yay -Qqe)

filter() {
  gum filter --no-limit --text.foreground="99" --placeholder="Select a package to uninstall" \
    --match.foreground="69"
}

selection=$(echo "$pkg_names\n" | filter)

sudo pacman -Rns $selection --noconfirm

gum confirm "$selection uninstalled. Select yes to exit."
