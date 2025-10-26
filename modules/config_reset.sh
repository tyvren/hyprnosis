#!/bin/bash

#BACK UP YOUR CONFIG FILES BEFORE RUNNING
#This script will reset config files back to the hyprnosis default state. Useful for major changes that would potentially break parts of the system. Resets: Hyprland, Waybar, Walker, Elephant.

#Directories
INSTALL_DIR="$HOME/.config/hyprnosis"
CONFIG_DIR="$HOME/.config/hyprnosis/config"
LOCAL_CONFIG="$HOME/.config"

#Update repo in default location
git clone https://github.com/tyvren/hyprnosis.git "$INSTALL_DIR"

#Update wallpapers
git clone --depth 1 https://github.com/tyvren/hyprnosis-wallpapers.git /tmp/wallpapers
rm -rf /tmp/wallpapers/.git
cp -r /tmp/wallpapers/. "$INSTALL_DIR/wallpapers/"
rm -rf /tmp/wallpapers

#Update Configs
rm -r $HOME/.config/walker
rm -r $HOME/.config/elephant
rm -r $HOME/.config/hypr/settings/theme.conf
cp -r "$CONFIG_DIR/gtk-3.0" "$LOCAL_CONFIG"
cp -r "$CONFIG_DIR/gtk-4.0" "$LOCAL_CONFIG"
cp -r "$CONFIG_DIR/nvim" "$LOCAL_CONFIG"
cp -r "~/.config/hyprnosis/themes/Hyprnosis/hypr" "$LOCAL_CONFIG"

#Restart services
systemctl --user restart waybar.service
systemctl --user restart elephant.service
systemctl --user restart walker.service
hyprctl reload
