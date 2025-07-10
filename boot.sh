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

INSTALL_DIR="$HOME/.config/hyprnosis"
git clone --depth 1 git@github.com:steve-conrad/hyprnosis.git "$INSTALL_DIR"

echo "Starting Hyprnosis installation..."
cd "$INSTALL_DIR"
chmod +x ./hyprnosis.sh
./hyprnosis.sh
