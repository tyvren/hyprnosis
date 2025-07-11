#!/bin/bash
set -e
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
EOF
}
clear
print_logo

pacman -Q git &>/dev/null || sudo pacman -Sy --noconfirm --needed git

INSTALL_DIR="$HOME/.config/hyprnosis"

if [ -d "$INSTALL_DIR/.git" ]; then
  echo "Repository already exists at $INSTALL_DIR. Skipping clone."
else
  git clone --depth 1 https://github.com/steve-conrad/hyprnosis.git "$INSTALL_DIR"
fi

echo "Starting Hyprnosis installation..."
cd "$INSTALL_DIR"
chmod +x ./hyprnosis.sh
source ./hyprnosis.sh
