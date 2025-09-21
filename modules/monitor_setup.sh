#Checks hyprctl monitors for the optimal resolution and refresh rates and applies to hyprland monitor config file

#Capture full hyprctl monitor info
monitors=$(hyprctl monitors)

#Capture monitor name
name=$(echo "$monitors" | grep "Monitor" | awk '{print $2}')

#Capture monitor modes
mode=$(echo "$monitors" | grep "availableModes" | awk '{print $2}')

#Write to hyprland monitor config
sed -i "s/^#monitor=DP-1.*/monitor=${name},${mode},auto,1.5/" ~/.config/hypr/settings/monitors.conf
