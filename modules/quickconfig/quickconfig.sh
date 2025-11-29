#!/bin/bash

clear

gum style \
  --foreground 37 --border-foreground 69 --border double \
  --align center --width 50 --margin "1 0" --padding "0 2" \
  'quickconfig - hyprland config utility'

config_choice=$(gum choose "Autostart" "Default Apps" "Input" "Keybinds" "Monitors" "Windows and Workspaces" "Hyprland" "Hypridle" "Hyprlock" "Waybar" "Exit")
case "$config_choice" in
"Autostart")
  autostart_choice=$(gum choose "Config TUI" "Manual Config" "Back ")
  case "$autostart_choice" in
  "Config TUI")
    bash ~/.config/hyprnosis/modules/quickconfig/autostart_apps.sh
    gum confirm "Press enter to return to menu." && exec "$0"
    ;;
  "Manual Config")
    nvim ~/.config/hypr/settings/autostart.conf
    ;;
  "Back ")
    gum confirm "Press enter to return to menu." && exec "$0"
    ;;
  esac
  ;;

"Default Apps")
  defaultapps_choice=$(gum choose "Manual Config" "Back ")
  case "$defaultapps_choice" in
  "Manual Config")
    nvim ~/.config/hypr/settings/default-apps.conf
    ;;
  "Back ")
    gum confirm "Press enter to return to menu." && exec "$0"
    ;;
  esac
  ;;

"Input")
  input_choice=$(gum choose "Config TUI" "Manual Config" "Back ")
  case "$input_choice" in
  "Config TUI")
    bash ~/.config/hyprnosis/modules/quickconfig/input.sh
    gum confirm "Press enter to return to menu." && exec "$0"
    ;;
  "Manual Config")
    nvim ~/.config/hypr/settings/input.conf
    ;;
  "Back ")
    gum confirm "Press enter to return to menu." && exec "$0"
    ;;
  esac
  ;;

"Keybinds")
  keybinds_choice=$(gum choose "Manual Config" "Back ")
  case "$keybinds_choice" in
  "Manual Config")
    nvim ~/.config/hypr/settings/keybinds.conf
    ;;
  "Back ")
    gum confirm "Press enter to return to menu." && exec "$0"
    ;;
  esac
  ;;

"Monitors")
  monitors_choice=$(gum choose "Config TUI" "Manual Config" "Back ")
  case "$monitors_choice" in
  "Config TUI")
    bash ~/.config/hyprnosis/modules/quickconfig/monitors.sh
    gum confirm "Press enter to return to menu." && exec "$0"
    ;;
  "Manual Config")
    nvim ~/.config/hypr/settings/monitors.conf
    ;;
  "Back ")
    gum confirm "Press enter to return to menu." && exec "$0"
    ;;
  esac
  ;;

"Windows and Workspaces")
  waw_choice=$(gum choose "Config TUI" "Manual Config" "Back ")
  case "$waw_choice" in
  "Config TUI")
    bash ~/.config/hyprnosis/modules/quickconfig/windows_workspaces.sh
    ;;
  "Manual Config")
    nvim ~/.config/hypr/settings/windows-and-workspaces.conf
    ;;
  "Back ")
    gum confirm "Press enter to return to menu." && exec "$0"
    ;;
  esac
  ;;

"Hyprland")
  hypr_choice=$(gum choose "Manual Config" "Back ")
  case "$hypr_choice" in
  "Manual Config")
    nvim ~/.config/hypr/hyprland.conf
    ;;
  "Back ")
    gum confirm "Press enter to return to menu." && exec "$0"
    ;;
  esac
  ;;

"Hypridle")
  idle_choice=$(gum choose "Config TUI" "Manual Config" "Back ")
  case "$idle_choice" in
  "Config TUI")
    bash ~/.config/hyprnosis/modules/quickconfig/hypridle.sh
    gum confirm "Press enter to return to menu." && exec "$0"
    ;;
  "Manual Config")
    nvim ~/.config/hypr/hypridle.conf
    ;;
  "Back ")
    gum confirm "Press enter to return to menu." && exec "$0"
    ;;
  esac
  ;;

"Hyprlock")
  hyprlock_choice=$(gum choose "Manual Config" "Back ")
  case "$hyprlock_choice" in
  "Manual Config")
    nvim ~/.config/hypr/hyprlock.conf
    ;;
  "Back ")
    gum confirm "Press enter to return to menu." && exec "$0"
    ;;
  esac
  ;;

"Waybar")
  waybar_choice=$(gum choose "CPU Temp Autoconfig" "Manual Config" "Back ")
  case "$waybar_choice" in
  "CPU Temp Autoconfig")
    bash ~/.config/hyprnosis/modules/quickconfig/waybar_cpu.sh
    ;;
  "Manual Config")
    nvim ~/.config/waybar/config.jsonc
    ;;
  "Back ")
    gum confirm "Press enter to return to menu." && exec "$0"
    ;;
  esac
  ;;

"Exit")
  clear
  exit 0
  ;;
esac
