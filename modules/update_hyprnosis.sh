#!/bin/bash

INSTALL_DIR="$HOME/.config/hyprnosis"
CONFIG_DIR="$HOME/.config/hyprnosis/config"
LOCAL_CONFIG="$HOME/.config"
BRANCH="main"
git -C "$INSTALL_DIR" fetch origin
git -C "$INSTALL_DIR" reset --hard origin/$BRANCH

[ -d /tmp/wallpapers ] && rm -rf /tmp/wallpapers

git clone --depth 1 https://github.com/tyvren/hyprnosis-wallpapers.git /tmp/wallpapers && \
rm -rf /tmp/wallpapers/.git && \
cp -r /tmp/wallpapers/. "$INSTALL_DIR/wallpapers/" && \
rm -rf /tmp/wallpapers

rm -r $HOME/.config/walker
cp -ru $CONFIG_DIR/walker $LOCAL_CONFIG
cp -ru $CONFIG_DIR/elephant $LOCAL_CONFIG
