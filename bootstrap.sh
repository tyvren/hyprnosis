#!/bin/bash
set -e

INSTALL_DIR="$HOME/.config/hyprnosis"
git clone --depth 1 git@github.com:steve-conrad/hyprnosis.git "$INSTALL_DIR"

echo "Running install script..."
cd "$INSTALL_DIR"
chmod +x ./hyprnosis.sh
./hyprnosis.sh
