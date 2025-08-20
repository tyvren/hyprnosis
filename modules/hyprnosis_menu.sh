#!/bin/bash

menu() {
    local prompt="$1"
    local options="$2"
    echo -e "$options" | walker --dmenu -H -p "$prompt…"
}

present_terminal() {
    ghostty -e bash -c "$1"
}

main_items="  Power Menu\n  Update\n Keybinds"

selection=$(menu "Hyprnosis Menu" "$main_items")

case "$selection" in
    *Power*) exec ~/.config/hyprnosis/modules/power_menu.sh ;;
    *Update*) exec ~/.config/hyprnosis/modules/hyprnosis_update.sh ;;
    *Keybinds*) exec ~/.config/hyprnosis/modules/wofi_keybinds.sh ;;
esac

