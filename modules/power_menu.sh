#!/bin/bash

menu() {
    local prompt="$1"
    local options="$2"
    echo -e "$options" | walker --dmenu -H -p "$prompt…"
}

items=" Shutdown\n Restart\n Lock"

selection=$(menu "Power Menu" "$items")

case "$selection" in
    *Shutdown*) systemctl poweroff ;;
    *Restart*) systemctl reboot ;;
    *Lock*) hyprlock ;;
esac

