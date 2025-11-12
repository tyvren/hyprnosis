#!/bin/bash

set -e

pkg_names=$(yay -Slqa)

filter() {
  gum filter --no-limit --text.foreground="99" --placeholder="Search for an AUR pkg to install" \
    --match.foreground="69"
}

selection=$(echo "$pkg_names\n" | filter)

yay -Sy $selection --noconfirm

gum confirm "$selection installed. Select yes to exit."
