#!/bin/bash
set -e

source ./core/functions_test.sh

# Ensure Gum is installed
ensure_gum

clear
log_header "Hyprnosis Installer"

spinner "Installing git..." sudo pacman -Sy --noconfirm --needed git

INSTALL_DIR="$HOME/.config/hyprnosis"
log_step "Cloning Hyprnosis repository"
spinner "Cloning hyprnosis repo..." git clone https://github.com/tyvren/hyprnosis.git "$INSTALL_DIR"

log_step "Starting Hyprnosis installation"
cd "$INSTALL_DIR" || exit
spinner "Running primary installer..." source ./hyprnosis.sh
