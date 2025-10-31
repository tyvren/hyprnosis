#!/bin/bash

clear

gum style \
  --foreground 37 --border-foreground 69 --border double \
  --align center --width 50 --margin "1 0" --padding "0 2" \
  'hyprnosis menu'

main_choice=$(gum choose "Updates" "Packages" "Configure" "Exit")

case "$main_choice" in
"Updates")
  update_choice=$(gum choose "Update system" "Update hyprnosis" "Back ")
  case "$update_choice" in
  "Update system")
    clear
    bash ~/.config/hyprnosis/modules/update_system.sh

    gum confirm "Press enter to return to menu." && exec "$0"
    ;;

  "Update hyprnosis")
    bash ~/.config/hyprnosis/modules/update_hyprnosis.sh
    ;;

  "Back ")
    gum confirm "Press enter to return to menu." && exec "$0"
    ;;
  esac
  ;;

"Packages")
  package_choice=$(gum choose "Install Arch Package" "Install AUR Package" "Uninstall Package" "Back ")
  case "$package_choice" in
  "Install Arch Package")
    bash ~/.config/hyprnosis/modules/pkg_install.sh
    gum confirm "Press enter to return to menu." && exec "$0"
    ;;

  "Install AUR Package")
    bash ~/.config/hyprnosis/modules/pkg_aur_install.sh
    gum confirm "Press enter to return to menu." && exec "$0"
    ;;

  "Uninstall Package")
    bash ~/.config/hyprnosis/modules/pkg_uninstall.sh
    gum confirm "Press enter to return to menu." && exec "$0"
    ;;

  "Back ")
    gum confirm "Press enter to return to menu." && exec "$0"
    ;;
  esac
  ;;

"Configure")
  config_choice=$(gum choose "Autostart" "Default Apps" "Input" "Keybinds" "Monitors" "Windows and Workspaces" "Hyprland" "Hypridle" "Waybar" "Back ")
  case "$config_choice" in
  "Autostart")
    CONFIG_PATH="$HOME/.config/hypr/settings/autostart.conf"

    autostart_choice=$(gum choose "Add App" "Remove App" "Back " --header "Manage Autostart Apps")
    case "$autostart_choice" in
    "Add App")
      app_name=$(gum input --placeholder "Enter app name(e.g. firefox)")
      if [ -n "$app_name" ]; then
        new_app="exec-once = uwsm app -- $app_name"
        sed -i "/#Admin authentication agent/i $new_app" "$CONFIG_PATH"
        echo "Added: $new_app"
      fi
      ;;

    "Remove App")
      apps=$(sed -n '/#Autostart these apps/,/#Admin authentication agent/{/#/!p}' "$config_path")

      selected=$(echo "$apps" | gum choose --header "Select an app to remove from startup")
      [ -z "$selected" ] && exit 0

      sed -i "\|$selected|d" "$config_path"
      echo "Removed: $selected"
      ;;

    "Back ")
      gum confirm "Press enter to return to menu." && exec "$0"
      ;;
    esac
    ;;

  "Default Apps")
    nvim ~/.config/hypr/settings/default-apps.conf
    ;;

  "Input")
    nvim ~/.config/hypr/settings/input.conf
    ;;

  "Keybinds")
    nvim ~/.config/hypr/settings/keybinds.conf
    ;;

  "Monitors")
    monitors_choice=$(gum choose "Config TUI" "Manual Config" "Back ")
    case "$monitors_choice" in
    "Config TUI")
      bash ~/.config/hyprnosis/modules/monitor_setup.sh
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
    nvim ~/.config/hypr/settings/windows-and-workspaces.conf
    ;;

  "Hyprland")
    nvim ~/.config/hypr/hyprland.conf
    ;;

  "Hypridle")
    idle_choice=$(gum choose "Config TUI" "Manual Config" "Back ")
    case "$idle_choice" in
    "Config TUI")
      bash ~/.config/hyprnosis/modules/hypridle_setup.sh
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

  "Waybar")
    waybar_choice=$(gum choose "CPU Temp Autoconfig" "Manual Config" "Back ")
    case "$waybar_choice" in
    "CPU Temp Autoconfig")
      bash ~/.config/hyprnosis/modules/configure_waybar_cpu_sensor.sh
      ;;
    "Manual Config")
      nvim ~/.config/waybar/config.jsonc
      ;;
    "Back ")
      gum confirm "Press enter to return to menu." && exec "$0"
      ;;
    esac
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
clear
