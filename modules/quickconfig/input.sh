#!/bin/bash

gum style \
  --foreground 37 --border-foreground 69 --border double \
  --align center --width 50 --margin "1 0" --padding "0 2" \
  'Manage Input Devices'

CONFIG_PATH="$HOME/.config/hypr/settings/input.conf"

input_choice=$(gum choose "Follow Mouse" "Sensitivity" "Touchpad" "Back ")
case "$input_choice" in
"Follow Mouse")
  follow_choice=$(gum choose "0 - no focus" "1 - hover focus" "2 - click focus" "3 - separate focus")
  case "$follow_choice" in
  "0 - no focus")
    sed -i 's/follow_mouse = .*/follow_mouse = 0/' "$CONFIG_PATH"
    ;;
  "1 - hover focus")
    sed -i 's/follow_mouse = .*/follow_mouse = 1/' "$CONFIG_PATH"
    ;;
  "2 - click focus")
    sed -i 's/follow_mouse = .*/follow_mouse = 2/' "$CONFIG_PATH"
    ;;
  "3 - separate focus")
    sed -i 's/follow_mouse = .*/follow_mouse = 3/' "$CONFIG_PATH"
    ;;
  esac
  ;;

"Sensitivity")
  sensitivity_level=$(gum input --placeholder "Enter your mouse sensitivity level: -1.0 - 1.0, 0 - no modification")
  sed -i "s/sensitivity = .*/sensitivity = "$sensitivity_level"/" "$CONFIG_PATH"
  ;;

"Touchpad")
  natural_scroll=$(gum choose "Enable natural scroll" "Disable natural scroll")
  case "$natural_scroll" in
  "Enable natural scroll")
    sed -i 's/natural_scroll = .*/natural_scroll = true/' "$CONFIG_PATH"
    ;;
  "Disable natural scroll")
    sed -i 's/natural_scroll = .*/natural_scroll = false/' "$CONFIG_PATH"
    ;;
  esac
  ;;

"Back ")
  gum confirm "Press enter to return to menu." && exec "$0"
  ;;
esac
