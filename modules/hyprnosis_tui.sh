#!/bin/bash

clear

gum style \
	--foreground 99 --border-foreground 120 --border double \
	--align center --width 50 --margin "1 2" --padding "2 4" \
	'hyprnosis Menu'

main_choice=$(gum choose "Updates" "Packages" "Configure" "Exit")

case "$main_choice" in
  "Updates")
     update_choice=$(gum choose "Update system" "Update hyprnosis" "Back ")
     case "$update_choice" in
       "Update system")
          clear
	  gum style --foreground 99 --border double --padding "2 4" "System Update"
    	  yay -Syu
	
    	  gum confirm "Press enter to return to menu." && exec "$0"
    	  ;;

       "Update hyprnosis")
	  clear
	  gum style --foreground 99 --border double --padding "2 4" "Updating Hyprnosis..."
	  INSTALL_DIR="$HOME/.config/hyprnosis"
    	  BRANCH="main"
    	  git -C "$INSTALL_DIR" fetch origin
    	  git -C "$INSTALL_DIR" reset --hard origin/$BRANCH
    	  git clone --depth 1 https://github.com/steve-conrad/hyprnosis-wallpapers.git /tmp/wallpapers && \
    	  cp -r /tmp/wallpapers/. "$INSTALL_DIR/wallpapers/" && \
    	  rm -rf /tmp/wallpapers

    	  gum confirm "Press enter to return to menu." && exec "$0"
    	  ;;

       "Back ")
	  gum confirm "Press enter to return to menu." && exec "$0"
	  ;;
     esac
     ;;

  "Packages")
     package_choice=$(gum choose "Install Arch Package" "Install AUR Package" "Uninstall Package" "Back ")
     case "$package_choice" in
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

    	    gum confirm "Package Uninstalled. Press enter to return to menu." && exec "$0"
    	    ;;
      
	"Back ")
	    gum confirm "Press enter to return to menu." && exec "$0"
	    ;;
     esac
     ;;

  "Configure")
     config_choice=$(gum choose "Autostart" "Default Apps" "Input" "Keybinds" "Monitors" "Windows and Workspaces" "Hyprland" "Hypridle" "Back ")
     case "$config_choice" in
	"Autostart")
	    nvim ~/.config/hypr/settings/autostart.conf
	    ;;

 	"Default Apps")
	    nvim ~/.config/hypr/settings/default-apps.conf
	    ;;

	"Input")
	    nvim ~/.config/hypr/settings/input.conf	
	    ;;

	"Keybinds")
	    nvim ~/.config/hypr/settings/keybinds.conf
	    ;;

	"Monitors")
	    nvim ~/.config/hypr/settings/monitors.conf
	    ;;

        "Windows and Workspaces")
	    nvim ~/.config/hypr/settings/windows-and-workspaces.conf
	    ;;

	"Hyprland")
	    nvim ~/.config/hypr/hyprland.conf
	    ;;

    	"Hypridle")
	    nvim ~/.config/hypr/hypridle.conf
	    ;;

	"Back ")
	    gum confirm "Press enter to return to menu." && exec "$0"
	    ;;

     esac
     ;;

  "Exit")
    clear
    exit 0
    ;;

esac
