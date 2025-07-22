#!/bin/bash

source ./core/functions.sh
source ./core/packages.sh

get_username
sudo -v
sudo pacman -Syu --noconfirm
install_yay
install_gpu_driver
install_packages "${system_utils[@]}"
install_packages "${app_packages[@]}"
install_packages "${hypr_packages[@]}"
enable_service "networkmanager"
enable_service "bluetooth.service"
enable_service "cups"
enable_user_service "waybar.service"
enable_coolercontrol
config_setup
hyprland_autologin
