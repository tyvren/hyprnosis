#!/bin/bash

menu() {
    local prompt="$1"
    local options="$2"
    echo -e "$options" | walker --dmenu -H -p "$prompt…"
}

present_terminal() {
    ghostty -e bash -c "$1"
}

main_items="  Power Menu\n  Update\n  Keybinds\n Themes\n  Learn"

selection=$(menu "Hyprnosis Menu" "$main_items")

case "$selection" in
    *Power*) exec ~/.config/hyprnosis/modules/power_menu.sh ;;
    *Update*) exec ~/.config/hyprnosis/modules/update.sh ;;
    *Keybinds*) exec ~/.config/hyprnosis/modules/wofi_keybinds.sh ;;
    *Themes*) exec ~/.config/hyprnosis/modules/theme_changer.sh ;;
    *Learn*) exec ~/.config/hyprnosis/modules/learn.sh ;;
esac
