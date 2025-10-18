#!/bin/bash

source ./core/functions.sh
source ./core/packages.sh

print_logo() {
	cat << "EOF"
 ██▓ ███▄    █   ██████ ▄▄▄█████▓ ▄▄▄       ██▓     ██▓     ██▓ ███▄    █   ▄████    
▓██▒ ██ ▀█   █ ▒██    ▒ ▓  ██▒ ▓▒▒████▄    ▓██▒    ▓██▒    ▓██▒ ██ ▀█   █  ██▒ ▀█▒   
▒██▒▓██  ▀█ ██▒░ ▓██▄   ▒ ▓██░ ▒░▒██  ▀█▄  ▒██░    ▒██░    ▒██▒▓██  ▀█ ██▒▒██░▄▄▄░   
░██░▓██▒  ▐▌██▒  ▒   ██▒░ ▓██▓ ░ ░██▄▄▄▄██ ▒██░    ▒██░    ░██░▓██▒  ▐▌██▒░▓█  ██▓   
░██░▒██░   ▓██░▒██████▒▒  ▒██▒ ░  ▓█   ▓██▒░██████▒░██████▒░██░▒██░   ▓██░░▒▓███▀▒   
░▓  ░ ▒░   ▒ ▒ ▒ ▒▓▒ ▒ ░  ▒ ░░    ▒▒   ▓▒█░░ ▒░▓  ░░ ▒░▓  ░░▓  ░ ▒░   ▒ ▒  ░▒   ▒    
 ▒ ░░ ░░   ░ ▒░░ ░▒  ░ ░    ░      ▒   ▒▒ ░░ ░ ▒  ░░ ░ ▒  ░ ▒ ░░ ░░   ░ ▒░  ░   ░    
 ▒ ░   ░   ░ ░ ░  ░  ░    ░        ░   ▒     ░ ░     ░ ░    ▒ ░   ░   ░ ░ ░ ░   ░    
 ░           ░       ░                 ░  ░    ░  ░    ░  ░ ░           ░       ░    
                                                                                     
 ██░ ██▓██   ██▓ ██▓███   ██▀███   ███▄    █  ▒█████    ██████  ██▓  ██████          
▓██░ ██▒▒██  ██▒▓██░  ██▒▓██ ▒ ██▒ ██ ▀█   █ ▒██▒  ██▒▒██    ▒ ▓██▒▒██    ▒          
▒██▀▀██░ ▒██ ██░▓██░ ██▓▒▓██ ░▄█ ▒▓██  ▀█ ██▒▒██░  ██▒░ ▓██▄   ▒██▒░ ▓██▄            
░▓█ ░██  ░ ▐██▓░▒██▄█▓▒ ▒▒██▀▀█▄  ▓██▒  ▐▌██▒▒██   ██░  ▒   ██▒░██░  ▒   ██▒         
░▓█▒░██▓ ░ ██▒▓░▒██▒ ░  ░░██▓ ▒██▒▒██░   ▓██░░ ████▓▒░▒██████▒▒░██░▒██████▒▒         
 ▒ ░░▒░▒  ██▒▒▒ ▒▓▒░ ░  ░░ ▒▓ ░▒▓░░ ▒░   ▒ ▒ ░ ▒░▒░▒░ ▒ ▒▓▒ ▒ ░░▓  ▒ ▒▓▒ ▒ ░         
 ▒ ░▒░ ░▓██ ░▒░ ░▒ ░       ░▒ ░ ▒░░ ░░   ░ ▒░  ░ ▒ ▒░ ░ ░▒  ░ ░ ▒ ░░ ░▒  ░ ░         
 ░  ░░ ░▒ ▒ ░░  ░░         ░░   ░    ░   ░ ░ ░ ░ ░ ▒  ░  ░  ░   ▒ ░░  ░  ░           
 ░  ░  ░░ ░                 ░              ░     ░ ░        ░   ░        ░           
        ░ ░                                                                          
EOF
}
clear
print_logo

get_username
sudo pacman -Syu --noconfirm
install_yay
install_gpu_packages
install_packages "${system_utils[@]}"
install_packages "${app_packages[@]}"
install_packages "${hypr_packages[@]}"
enable_service "networkmanager"
enable_service "bluetooth.service"
enable_service "cups"
enable_service "lm_sensors"
enable_user_service "waybar.service"
enable_elephant_service
enable_walker_service
config_setup
enable_plymouth
setup_hyprnosis_alias
hyprland_autologin
