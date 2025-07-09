#!/bin/bash

print_logo() {
	cat << "EOF"
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

source ./functions.sh
source ./packages.sh

echo "Installing Hyprnosis dependencies..."
#Install system update
sudo pacman -Syu --noconfirm
#Install yay
sudo pacman -S --noconfirm git base-devel --noconfirm
rm -rf yay
git clone https://aur.archlinux.org/yay/git
cd yay
makepkg -si --noconfirm
cd ..
rm -rf yay

echo "Installing GPU drivers..."
install_gpu_driver

echo "installing system utilities..."
install_packages "${system_utils[@]}" 

echo "Enabling system services..."
enable_service "networkmanager"
enable_service "bluetooth.service"
enable_service "cups"

#Prompt before running sensors-detect
echo "Running fan and thermal sensor detection (lm_sensors)"
read -rp "This will prompt for several yes/no hardware questions. Run now? [y/N]: " run_sensors
  if [[ "$run_sensors" =~ ^[Yy]$ ]]; then
    sudo sensors-detect
  else
    echo "Skipped sensors-detect."
  fi

echo "installing Hyprnosis packages..."
install_packages "${app_packages[@]}"
install_packages "${hypr_packages[@]}"
