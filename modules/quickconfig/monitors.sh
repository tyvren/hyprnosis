#!/bin/bash

clear

config_path="$HOME/.config/hypr/settings/monitors.conf"
monitors=$(hyprctl monitors)

readarray -t connection_types < <(echo "$monitors" | grep "^Monitor" | awk '{print $2}')
readarray -t model_names < <(echo "$monitors" | grep "model" | awk '{print $3}')

display_list=()
for i in "${!connection_types[@]}"; do
  display_list+=("${connection_types[$i]} - ${model_names[$i]}")
done

header() {
  gum style --foreground 99 --border double --align center --margin "1 2" --padding "2 4" \
    "$1"
}

header "Select the monitor to configure"
monitor_choice=$(printf "%s\n" "${display_list[@]}" | gum choose --limit=1) || exit 0
[[ -z "$monitor_choice" ]] && exit 0

selected_connection=$(echo "$monitor_choice" | awk '{print $1}')

monitor_info=$(echo "$monitors" | awk "/Monitor $selected_connection/,/^$/")

modes=$(echo "$monitor_info" | grep "availableModes" | sed 's/^[[:space:]]*availableModes: //')
mode_list=$(echo "$modes" | tr ' ' '\n')

clear
header "Select the resolution and refresh rate"
chosen_mode=$(echo "$mode_list" | gum choose --limit=1) || exit 0
[[ -z "$chosen_mode" ]] && exit 0

clear
header "Select the monitor's position"
position=$(printf "auto\nauto-left\nauto-right\n" | gum choose --limit=1) || exit 0
[[ -z "$position" ]] && exit 0
clear

header "Select the display scaling for hyprland"
chosen_scale=$(printf "1\n1.5\n2\n" | gum choose --limit=1) || exit 0
[[ -z "$chosen_scale" ]] && exit 0

clear
header "Select the display scaling for GDK apps (Steam, Discord)- Requires a reboot to apply"
chosen_gdkscale=$(printf "1\n2\n" | gum choose --limit=1) || exit 0
[[ -z "$chosen_gdkscale" ]] && exit 0

clear

sed -i "/^monitor=${selected_connection}/d" "$config_path"

sed -i "/^monitor=,preferred,auto, 1/a monitor=${selected_connection},${chosen_mode},${position},${chosen_scale}" "$config_path"

sed -i "s/^env = GDK_SCALE,.*/env = GDK_SCALE,${chosen_gdkscale}/" "$config_path"

gum confirm "Press enter to return to menu." && exec "$0"
