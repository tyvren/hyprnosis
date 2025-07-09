#!/bin/bash
set -e

INSTALL_DIR="$HOME/.config/hyprnosis"

if [[ ! -d "$INSTALL_DIR/.git" ]]; then
  echo "Cloning hyprnosis into $INSTALL_DIR..."
  git clone --depth 1 git@github.com:steve-conrad/hyprnosis.git "$INSTALL_DIR"
else
  echo "Updating hyprnosis in $INSTALL_DIR..."
  git -C "$INSTALL_DIR" pull --ff-only
fi

echo "Running install script..."
cd "$INSTALL_DIR"
chmod +x ./hyprnosis.sh
./hyprnosis.sh "$@"

