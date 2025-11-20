#!/bin/bash

clear

header() {
  gum style \
    --foreground 37 --border-foreground 69 --border double \
    --align center --width 50 --margin "1 0" --padding "0 2" \
    'System Updates'
}

prompt() {
  local text="$1"
  gum style --foreground 69 "$1"
}

repo_updates=$(sudo pacman -Qu 2>/dev/null)

header
gum spin --spinner dot --title "Checking for updates..." -- sleep 2

if [[ "$repo_updates" ]]; then
  gum spin --spinner dot --title "Updates found, installing Arch updates..." -- sudo pacman -Syu --noconfirm
  prompt "$repo_updates"
  prompt "Arch updates installed."
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
