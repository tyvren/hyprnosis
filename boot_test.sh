#!/bin/bash
set -e

# Ensure Gum is installed first
if ! command -v gum &>/dev/null; then
    echo "Installing gum..."
    sudo pacman -Sy --noconfirm gum
fi

clear
gum style --bold --underline "Hyprnosis Installer"

spinner "Installing git..." sudo pacman -Sy --noconfirm --needed git

INSTALL_DIR="$HOME/.config/hyprnosis"
log_step "Cloning Hyprnosis repository"
spinner "Cloning hyprnosis repo..." git clone https://github.com/tyvren/hyprnosis.git "$INSTALL_DIR"

log_step "Starting Hyprnosis installation"
cd "$INSTALL_DIR" || exit
chmod +x ./hyprnosis_test.sh
spinner "Running primary installer..." bash ./hyprnosis_test.sh
