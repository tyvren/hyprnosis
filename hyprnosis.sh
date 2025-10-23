#!/bin/bash
set -e

source ./core/functions.sh
source ./core/packages.sh

ensure_gum
create_log

log_header "hyprnosis"

log_step "Getting username"
get_username

log_step "Updating system packages"
spinner "Updating system..." sudo pacman -Syu --noconfirm

log_step "Installing yay AUR helper"
install_yay

log_step "Installing GPU packages"
install_gpu_packages

log_step "Installing system utilities"
install_packages "${system_utils[@]}"

log_step "Installing application packages"
install_packages "${app_packages[@]}"

log_step "Installing Hyprland packages"
install_packages "${hypr_packages[@]}"

log_step "Enabling essential services"
enable_service "networkmanager"
enable_service "bluetooth.service"
enable_service "cups"
enable_service "lm_sensors"

log_step "Enabling user services"
enable_user_service "waybar.service"
enable_elephant_service
enable_walker_service

log_step "Setting up configuration"
config_setup

log_step "Enabling Plymouth theme"
enable_plymouth

log_step "Setting up hyprnosis alias"
setup_hyprnosis_alias

log_step "Enabling Hyprland autologin"
hyprland_autologin

log_success "Hyprnosis installation complete!"
log_info "Please reboot for all changes to take effect."

if ask_yes_no "Reboot now?"; then
    clear
    spinner "Rebooting system..." sudo systemctl reboot --no-wall 2>/dev/null || reboot 2>/dev/null
fi

