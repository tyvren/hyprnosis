#!/bin/bash

clear

header() {
  gum style \
    --foreground 37 --border-foreground 69 --border double \
    --align center --width 50 --margin "1 0" --padding "0 2" \
    'AUR Updates'
}

prompt() {
  gum style --foreground 69 "$1"
}

aur_updates=$(yay -Qua)

header
gum spin --spinner dot --title "Checking for updates..." -- sleep 2

if [[ "$aur_updates" ]]; then
  prompt "$aur_updates"
  sudo -v
  gum spin --spinner dot --title "Updates found, installing AUR updates..." -- yay --aur --noconfirm
  prompt "AUR updates installed."
else
  prompt "No AUR updates available."
fi

gum confirm "AUR update check complete. Press enter to close."
