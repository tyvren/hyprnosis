#!/bin/bash

menu() {
    local prompt="$1"
    local options="$2"
    echo -e "$options" | walker --dmenu -H -p "$prompt…"
}

present_terminal() {
    ghostty -e bash -c "$1"
}

main_items=" Apps\n  Power\n  Update\n Packages\n Themes\n  Keybinds\n  Learn"

selection=$(menu "Hyprnosis Menu" "$main_items")

case "$selection" in
    *Apps*) exec uwsm app -- walker ;;
    *Power*) exec ~/.config/hyprnosis/modules/power_menu.sh ;;
    *Update*) exec ~/.config/hyprnosis/modules/update.sh ;;
    *Packages*) exec ~/.config/hyprnosis/modules/manage_packages_menu.sh ;;
    *Themes*) exec ~/.config/hyprnosis/modules/theme_changer.sh ;;
    *Keybinds*) exec ~/.config/hyprnosis/modules/wofi_keybinds.sh ;;
    *Learn*) exec ~/.config/hyprnosis/modules/learn.sh ;;
esac
