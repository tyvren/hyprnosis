#!/bin/bash

clear

gum style --foreground 212 --border double --padding "1 3" --margin "1 0" 'hyprnosis'

CHOICE=$(gum choose --cursor.bold "Update system" "Update hyprnosis" "Install Arch Package" "Install AUR Package" "Uninstall Package" "Exit")

case "$CHOICE" in
  "Update system")
    clear
    gum style --foreground 99 --border double --padding "1 3" "System Update (interactive)"
    yay -Syu
    gum confirm "Updates complete. Press enter to return to menu." && exec "$0"
    ;;

  "Update hyprnosis")
    INSTALL_DIR="$HOME/.config/hyprnosis"
    BRANCH="main"
    
    gum style --foreground 212 "Updating Hyprnosis..."

    git -C "$INSTALL_DIR" fetch origin
    git -C "$INSTALL_DIR" reset --hard origin/$BRANCH
    git clone --depth 1 https://github.com/steve-conrad/hyprnosis-wallpapers.git /tmp/wallpapers && \
    cp -r /tmp/wallpapers/. "$INSTALL_DIR/wallpapers/" && \
    rm -rf /tmp/wallpapers
    cp -r "$INSTALL_DIR/themes/Hyprnosis/." "$HOME/.config/"
    cp -r "$HOME/.config/hyprnosis/config/"* "$HOME/.config/"

    gum confirm "Hyprnosis updated. Press enter to return to menu." && exec "$0"
    ;;

  "Install Arch Package")
    fzf_args=(
      --multi
      --preview 'pacman -Sii {1}'
      --preview-label='alt-p: toggle description, alt-j/k: scroll, tab: multi-select, F11: maximize'
      --preview-label-pos='bottom'
      --preview-window 'down:65%:wrap'
      --bind 'alt-p:toggle-preview'
      --bind 'alt-d:preview-half-page-down,alt-u:preview-half-page-up'
      --bind 'alt-k:preview-up,alt-j:preview-down'
      --color 'pointer:green,marker:green'
    )

    sudo pacman -Sy
    pkg_names=$(pacman -Slq | fzf "${fzf_args[@]}")

    if [[ -n "$pkg_names" ]]; then
      echo "$pkg_names" | tr '\n' ' ' | xargs sudo pacman -Sy --noconfirm
      sudo updatedb
    fi

    gum confirm "Arch package installed. Press enter to return to menu." && exec "$0"
    ;;

  "Install AUR Package")
    fzf_args=(
      --multi
      --preview 'yay -Sii {1}'
      --preview-label='alt-p: toggle description, alt-j/k: scroll, tab: multi-select, F11: maximize'
      --preview-label-pos='bottom'
      --preview-window 'down:65%:wrap'
      --bind 'alt-p:toggle-preview'
      --bind 'alt-d:preview-half-page-down,alt-u:preview-half-page-up'
      --bind 'alt-k:preview-up,alt-j:preview-down'
      --color 'pointer:green,marker:green'
    )

    pkg_names=$(yay -Slqa | fzf "${fzf_args[@]}")

    if [[ -n "$pkg_names" ]]; then
      echo "$pkg_names" | tr '\n' ' ' | xargs yay -Sy --noconfirm
      sudo updatedb
    fi

    gum confirm "AUR package installed. Press enter to return to menu." && exec "$0"
    ;;

  "Uninstall Package")
    fzf_args=(
      --multi
      --preview 'yay -Qi {1}'
      --preview-label='alt-p: toggle description, alt-j/k: scroll, tab: multi-select, F11: maximize'
      --preview-label-pos='bottom'
      --preview-window 'down:65%:wrap'
      --bind 'alt-p:toggle-preview'
      --bind 'alt-d:preview-half-page-down,alt-u:preview-half-page-up'
      --bind 'alt-k:preview-up,alt-j:preview-down'
      --color 'pointer:red,marker:red'
    )

    pkg_names=$(yay -Qqe | fzf "${fzf_args[@]}")

    if [[ -n "$pkg_names" ]]; then
      echo "$pkg_names" | tr '\n' ' ' | xargs sudo pacman -Rns --noconfirm
      sudo updatedb
    fi

    gum confirm "Package uninstalled. Press enter to return to menu." && exec "$0"
    ;;

  "Exit")
    clear
    exit 0
    ;;
esac
