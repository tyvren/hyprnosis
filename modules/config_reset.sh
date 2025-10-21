#!/bin/bash

#BACK UP YOUR CONFIG FILES BEFORE RUNNING
#This script will reset config files back to the hyprnosis default state. Useful for major changes that would otherwise break parts of the system. Resets: Hyprland, Waybar, Walker, Elephant.

#Directories
INSTALL_DIR="$HOME/.config/hyprnosis"
CONFIG_DIR="$HOME/.config/hyprnosis/config"
LOCAL_CONFIG="$HOME/.config"

#Update Wallpapers
git -C "$INSTALL_DIR" fetch origin
git -C "$INSTALL_DIR" reset --hard origin/main
[ -d /tmp/wallpapers ] && rm -rf /tmp/wallpapers
git clone --depth 1 https://github.com/tyvren/hyprnosis-wallpapers.git /tmp/wallpapers && \
rm -rf /tmp/wallpapers/.git && \
cp -r /tmp/wallpapers/. "$INSTALL_DIR/wallpapers/" && \
rm -rf /tmp/wallpapers

#Update Configs
rm -r $HOME/.config/walker
rm -r $HOME/.config/elephant
cp -r "$CONFIG_DIR"/. "$LOCAL_CONFIG"
