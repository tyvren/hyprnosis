#!/bin/bash

clear

gum style \
  --foreground 37 --border-foreground 69 --border double \
  --align center --width 50 --margin "1 0" --padding "0 2" \
  'Manage Window and Workspace behavior'

CONFIG_PATH="$HOME/.config/hypr/settings/windows-and-workspaces.conf"

waw_choice=$(gum choose "Single Window Aspect Ratio" "Back ")
case "$waw_choice" in
"Single Window Aspect Ratio")
  ratio_choice=$(gum choose "Fullscreen" "Centered")
  case "$ratio_choice" in
  "Fullscreen")
    sed -i 's/single_window_aspect_ratio = .*/single_window_aspect_ratio = 16 9/' "$CONFIG_PATH"
    ;;
  "Centered")
    sed -i 's/single_window_aspect_ratio = .*/single_window_aspect_ratio = 6 5/' "$CONFIG_PATH"
    ;;
  esac
  ;;
"Back ")
  gum confirm "Press enter to return to menu." && exec "$0"
  ;;
esac
