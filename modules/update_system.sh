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

repo_updates=$(pacman -Qu 2>/dev/null)
aur_updates=$(yay -Qua 2>/dev/null)

header
gum spin --spinner dot --title "Checking for updates..." -- sleep 2

if [[ -z "$repo_updates" && -z "$aur_updates" ]]; then
  prompt "No available updates."
  gum confirm "Press enter to close"
else
  sudo -v
  gum spin --spinner dot --title "Updates found, now installing..." -- yay -Syu --noconfirm

  prompt "Updates Installed."
  prompt "$repo_updates $aur_updates"

  running_kernel=$(uname -r | sed 's/-arch/\.arch/')
  installed_kernel=$(pacman -Q linux | awk '{print $2}')

  if [[ "$running_kernel" != "$installed_kernel" ]]; then
    prompt "Kernel update detected."

    if gum confirm "Reboot now to apply the new kernel?"; then
      systemctl reboot

    fi
  fi

  gum confirm "Updates Complete. Press enter to close."
fi
