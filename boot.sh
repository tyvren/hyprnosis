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

sudo pacman -Sy --noconfirm --needed git

INSTALL_DIR="$HOME/.config/hyprnosis"
echo -e "\nCloning hyprnosis"
git clone https://github.com/steve-conrad/hyprnosis.git "$INSTALL_DIR"

echo "Starting Hyprnosis installation..."
cd "$INSTALL_DIR"
chmod +x ./hyprnosis.sh
source ./hyprnosis.sh
