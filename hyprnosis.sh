#!/bin/bash
set -e

source ./core/functions.sh
source ./core/packages.sh

ensure_gum
create_log

header "hyprnosis"

log_step "Getting username"
get_username

log_step "Updating system packages" sudo pacman -Syu --noconfirm

log_step "Installing yay AUR helper" install_yay

log_step "Installing GPU packages" install_gpu_packages

log_step "Installing system utilities" install_packages "${system_utils[@]}"

log_step "Installing desktop environment packages" install_packages "${desktop_environment[@]}"

log_step "Installing development tools" install_packages "${development[@]}"

log_step "Installing terminal emulator and shell tools" install_packages "${terminal_shell[@]}"

log_step "Installing theme icons, cursors and fonts" install_packages "${themes_fonts_packages[@]}"

log_step "Installing application packages" install_packages "${app_packages[@]}"

log_step "Installing Hyprland packages" install_packages "${hypr_packages[@]}"

log_step "Enabling system services" bash -c '
    enable_service "networkmanager"
    enable_service "bluetooth.service"
    enable_service "cups"
    enable_service "lm_sensors"
'

log_step "Enabling user services" bash -c '
    enable_user_service "waybar.service"
    enable_elephant_service
    enable_walker_service
'

log_step "Setting up configuration" config_setup

log_step "Setting up hyprnosis bootloader logo" enable_plymouth

log_step "Setting up hyprnosis alias" setup_hyprnosis_alias

log_step "Configuring Hyprland login settings" hyprland_autologin

log_success "Hyprnosis installation complete!" 
log_info "Please reboot for all changes to take effect."

if prompt_yes_no "Reboot now?"; then
    clear
    spinner "Rebooting system..." sudo systemctl reboot --no-wall 2>/dev/null || reboot 2>/dev/null
fi
