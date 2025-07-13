#!/bin/bash

choice=$(printf "  Shutdown\n  Restart\n  Lock" | wofi --dmenu --width 300 --height 250 --cache-file /dev/null)

case "$choice" in
    "  Shutdown") systemctl poweroff ;;
    "  Restart") systemctl reboot ;;
    "  Lock") hyprlock ;;
esac
