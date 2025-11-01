#!/bin/bash

gum style \
  --foreground 37 --border-foreground 69 --border double \
  --align center --width 50 --margin "1 0" --padding "0 2" \
  'Manage Hyprland Autostart'

prompt() {
  local text="$1"
  gum style --foreground 69 "$1"
}

CONFIG_PATH="$HOME/.config/hypr/settings/autostart.conf"

autostart_choice=$(gum choose "Add App" "Remove App" "Back ")
case "$autostart_choice" in
"Add App")
  app_name=$(gum input --placeholder "Enter app name(e.g. firefox)")
  if [ -n "$app_name" ]; then
    new_app="exec-once = uwsm app -- $app_name"
    sed -i "/#Admin authentication agent/i $new_app" "$CONFIG_PATH"
    prompt "Added: $new_app"
  fi
  ;;

"Remove App")
  apps=$(sed -n '/#Autostart these apps/,/#Admin authentication agent/{/#/!p}' "$CONFIG_PATH")

  selected=$(echo "$apps" | gum choose --header "Select an app to remove from startup")
  [ -z "$selected" ] && exit 0

  sed -i "\|$selected|d" "$CONFIG_PATH"
  prompt "Removed: $selected"
  ;;

"Back ")
  gum confirm "Press enter to return to menu." && exec "$0"
  ;;
esac
