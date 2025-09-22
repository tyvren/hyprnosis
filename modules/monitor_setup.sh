#A simple gum tui for managing a single hyprland monitor config

clear

config_path="$HOME/.config/hypr/settings/monitors.conf"

#Capture full hyprctl monitor info
monitors=$(hyprctl monitors)

#Capture monitor connection type
type=$(echo "$monitors" | grep "Monitor" | awk '{print $2}')

#Capture monitor modes
modes=$(echo "$monitors" | grep "availableModes" | sed 's/^[[:space:]]*availableModes: //')

#Turn modes into a list
mode_list=$(echo "$modes" | tr ' ' '\n')

#Choose resolution and refresh rate
gum style --foreground 99 --border double --align center --margin "1 2" --padding "2 4" \
  "Select the resolution and refresh rate"
chosen_mode=$(echo "$mode_list" | gum choose --limit=1)

clear

#Choose scaling
gum style --foreground 99 --border double --align center --margin "1 2" --padding "2 4" \
  "Select the scale"
chosen_scale=$(printf "1\n1.5\n2\n" | gum choose --limit=1)

#Write to hyprland monitor config
sed -i "s/^monitor=.*/monitor=${type},${chosen_mode},auto,${chosen_scale}/" $config_path

gum confirm "Press enter to return to menu." && exec "$0"
