#!/bin/bash

menu() {
    local prompt="$1"
    local options="$2"
    echo -e "$options" | walker --dmenu -H -p "$prompt…"
}

items="Install Arch Package\nInstall AUR Package\nUninstall Package"

selection=$(menu "Manage Packages Menu" "$items")

case "$selection" in
    *Arch*) ghostty -e ~/.config/hyprnosis/modules/pkg_install.sh ;;
    *AUR*) ghostty -e ~/.config/hyprnosis/modules/pkg_aur_install.sh ;;
    *Uninstall*) ghostty -e ~/.config/hyprnosis/modules/pkg_uninstall.sh ;;
esac
