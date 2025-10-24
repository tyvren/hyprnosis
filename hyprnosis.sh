#!/bin/bash
set -e

source ./core/functions.sh
source ./core/packages.sh

ensure_gum
create_log

header "hyprnosis"

log_step "Getting username"
get_username

log_step "Updating system packages"
spinner "Updating system..." sudo pacman -Syu --noconfirm

spinner "Installing yay AUR helper" install_yay

spinner "Installing GPU packages" install_gpu_packages

spinner "Installing system utilities" install_packages "${system_utils[@]}"

spinner "Installing desktop environment packages" install_packages "${desktop_environment[@]}"

spinner "Installing development tools" install_packages "${development[@]}"

spinner "Installing terminal emulator and shell tools" install_packages "${terminal_shell[@]}"

spinner "Installing theme icons, cursors and fonts" install_packages "${themes_fonts_packages[@]}"

spinner "Installing application packages" install_packages "${app_packages[@]}"

spinner "Installing Hyprland packages" install_packages "${hypr_packages[@]}"

log_step "Enabling system services"
enable_service "networkmanager"
enable_service "bluetooth.service"
enable_service "cups"
enable_service "lm_sensors"

log_step "Enabling user services"
enable_user_service "waybar.service"
enable_elephant_service
enable_walker_service

spinner "Setting up configuration" config_setup
#Change other steps to use spinner while running - no need to show each individual output
spinner "Setting up hyprnosis bootloader logo" enable_plymouth

spinner "Setting up hyprnosis alias" setup_hyprnosis_alias

spinner "Configuring Hyprland login settings" hyprland_autologin

log_success "Hyprnosis installation complete!"
log_info "Please reboot for all changes to take effect."

if prompt_yes_no "Reboot now?"; then
    clear
    spinner "Rebooting system..." sudo systemctl reboot --no-wall 2>/dev/null || reboot 2>/dev/null
fi
