#!/bin/bash

clear

header() {
  gum style \
    --foreground 37 --border-foreground 69 --border double \
    --align center --width 50 --margin "1 0" --padding "0 2" \
    'System Updates'
}

prompt() {
  gum style --foreground 69 "$1"
}

repo_updates=$(sudo pacman -Qu)

header
gum spin --spinner dot --title "Checking for updates..." -- sleep 2

if [[ "$repo_updates" ]]; then
  prompt "$repo_updates"
  gum spin --spinner dot --title "Updates found, installing..." -- sudo pacman -Syu --noconfirm
  prompt "Updates installed."
else
  prompt "No Arch repo updates available."
fi

running_kernel=$(uname -r | sed 's/-arch/\.arch/')
installed_kernel=$(pacman -Q linux | awk '{print $2}')

if [[ "$running_kernel" != "$installed_kernel" ]]; then
  prompt "Kernel update detected."

  if gum confirm "Reboot now to apply the new kernel?"; then
    systemctl reboot
  fi
fi

gum confirm "Update check complete. Press enter to close."
