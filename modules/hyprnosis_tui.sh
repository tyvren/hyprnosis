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
	  cp -r $CONFIG_DIR/walker $LOCAL_CONFIG
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
     config_choice=$(gum choose "Autostart" "Default Apps" "Input" "Keybinds" "Monitors" "Windows and Workspaces" "Hyprland" "Hypridle" "Waybar" "Back ")
     case "$config_choice" in
	"Autostart")
	    config_path="$HOME/.config/hypr/settings/autostart.conf"

	    autostart_choice=$(gum choose "Add App" "Remove App" "Back " --header "Manage Autostart Apps")
     	    case "$autostart_choice" in
		"Add App")
		    app_name=$(gum input --placeholder "Enter app name(e.g. firefox)")
		    if [ -n "$app_name" ]; then
			new_app="exec-once = uwsm app -- $app_name"
			sed -i "/#Admin authentication agent/i $new_app" "$config_path"
			echo "Added: $new_app"
		    fi
		    ;;

		"Remove App")
    		    apps=$(sed -n '/#Autostart these apps/,/#Admin authentication agent/{/#/!p}' "$config_path")

    		    selected=$(echo "$apps" | gum choose --header "Select an app to remove from startup")
    		    [ -z "$selected" ] && exit 0

    		    sed -i "\|$selected|d" "$config_path"
    		    echo "Removed: $selected"
		    ;;

		"Back ")
		    gum confirm "Press enter to return to menu." && exec "$0"
		    ;;
    	    esac
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
	    monitors_choice=$(gum choose "Config TUI" "Manual Config" "Back ")
     	    case "$monitors_choice" in
		"Config TUI")
	    	    clear
	    	    config_path="$HOME/.config/hypr/settings/monitors.conf"
	    	    monitors=$(hyprctl monitors)

		    readarray -t connection_types < <(echo "$monitors" | grep "^Monitor" | awk '{print $2}')
		    readarray -t model_names < <(echo "$monitors" | grep "model" | awk '{print $3}')

		    display_list=()
		    for i in "${!connection_types[@]}"; do
    		        display_list+=("${connection_types[$i]} - ${model_names[$i]}")
		    done

		    gum style --foreground 99 --border double --align center --margin "1 2" --padding "2 4" \
		    "Select the monitor to configure"
		    monitor_choice=$(printf "%s\n" "${display_list[@]}" | gum choose --limit=1) || exit 0
		    [[ -z "$monitor_choice" ]] && exit 0

		    selected_connection=$(echo "$monitor_choice" | awk '{print $1}')

		    monitor_info=$(echo "$monitors" | awk "/Monitor $selected_connection/,/^$/" )

		    modes=$(echo "$monitor_info" | grep "availableModes" | sed 's/^[[:space:]]*availableModes: //')
		    mode_list=$(echo "$modes" | tr ' ' '\n')

		    gum style --foreground 99 --border double --align center --margin "1 2" --padding "2 4" \
		    "Select the resolution and refresh rate"
		    chosen_mode=$(echo "$mode_list" | gum choose --limit=1) || exit 0
		    [[ -z "$chosen_mode" ]] && exit 0
		    clear

		    gum style --foreground 99 --border double --align center --margin "1 2" --padding "2 4" \
		    "Select the monitor's position"
		    position=$(printf "auto\nauto-left\nauto-right\n" | gum choose --limit=1) || exit 0
		    [[ -z "$position" ]] && exit 0
		    clear

		    gum style --foreground 99 --border double --align center --margin "1 2" --padding "2 4" \
		    "Select the scale"
		    chosen_scale=$(printf "1\n1.5\n2\n" | gum choose --limit=1) || exit 0
		    [[ -z "$chosen_scale" ]] && exit 0
		    clear

		    sed -i "/^monitor=${selected_connection}/d" "$config_path"

		    sed -i "/^monitor=,preferred,auto, 1/a monitor=${selected_connection},${chosen_mode},${position},${chosen_scale}" "$config_path"

		    gum confirm "Press enter to return to menu." && exec "$0"
		    ;;

		"Manual Config")
	    	    nvim ~/.config/hypr/settings/monitors.conf
	    	    ;;

		"Back ")
		    gum confirm "Press enter to return to menu." && exec "$0"
		    ;;

	    esac
	    ;;

        "Windows and Workspaces")
	    nvim ~/.config/hypr/settings/windows-and-workspaces.conf
	    ;;

	"Hyprland")
	    nvim ~/.config/hypr/hyprland.conf
	    ;;

    	"Hypridle")
	    idle_choice=$(gum choose "Config TUI" "Manual Config" "Back ")
     	    case "$idle_choice" in
		"Config TUI")
	    	    clear
	    	    idleconfig="$HOME/.config/hypr/hypridle.conf"

		    gum style --foreground 99 --border double --align center --margin "1 2" --padding "2 4" \
			    "Choose display dim time (minutes)"
		    chosen_dimtime=$(printf "5\n10\n15\n30\n" | gum choose --limit=1)
	     	    clear

	    	    gum style --foreground 99 --border double --align center --margin "1 2" --padding "2 4" \
			    "Choose lock time (minutes)"
		    chosen_locktime=$(printf "5\n10\n15\n30\n" | gum choose --limit=1)
	     	    clear

	    	    gum style --foreground 99 --border double --align center --margin "1 2" --padding "2 4" \
			    "Choose display sleep time (minutes)"
	    	    chosen_displaytime=$(printf "10\n15\n30\n" | gum choose --limit=1)
		    clear

		    gum style --foreground 99 --border double --align center --margin "1 2" --padding "2 4" \
    		    "Enable computer sleep?"
		    enable_sleep_choice=$(printf "Yes\nNo" | gum choose --limit=1)
		    clear

		    if [ "$enable_sleep_choice" = "Yes" ]; then
		        enable_sleep=true
			gum style --foreground 99 --border double --align center --margin "1 2" --padding "2 4" \
			"Choose computer sleep time (minutes)"
	    	        chosen_sleeptime=$(printf "15\n30\n45\n60\n" | gum choose --limit=1)
		    else
		        enable_sleep=false
		    fi
		    clear

		    dim_seconds=$(( chosen_dimtime * 60 ))
		    lock_seconds=$(( chosen_locktime * 60 ))
		    display_seconds=$(( chosen_displaytime * 60 ))
		    sleep_seconds=$(( chosen_sleeptime * 60 ))

		    cat > "$idleconfig" <<-EOF
			general {
			  lock_cmd = pidof hyprlock || hyprlock
			  before_sleep_cmd = loginctl lock-session
			  after_sleep_cmd = hyprctl dispatch dpms on
			}

			listener {
			  timeout = $dim_seconds
			  on-timeout = brightnessctl -s set 10
			  on-resume = brightnessctl -r
			}

			listener {
			  timeout = $lock_seconds
			  on-timeout = loginctl lock-session
			}

			Turn off display
			listener {
			  timeout = $display_seconds
			  on-timeout = hyprctl dispatch dpms off
			  on-resume = hyprctl dispatch dpms on
			}
			EOF

		    if $enable_sleep; then

		    cat >> "$idleconfig" <<-EOF
			listener {
			  timeout = $sleep_seconds
			  on-timeout = systemctl suspend
			}
			EOF

		    else
			    
		    cat >> "$idleconfig" <<-'EOF'
			# listener {
			#   timeout = 1800
			#   on-timeout = systemctl suspend
			# }
			EOF
		    fi

	    	    gum confirm "Press enter to return to menu." && exec "$0"
		    ;;

		"Manual Config")
	    	    nvim ~/.config/hypr/hypridle.conf
		    ;;

		"Back ")
		    gum confirm "Press enter to return to menu." && exec "$0"
		    ;;
	    esac
	    ;;

	"Waybar")
	    waybar_choice=$(gum choose "CPU Temp Autoconfig" "Manual Config" "Back ")
     	    case "$waybar_choice" in
		"CPU Temp Autoconfig")
		    WAYBAR_CONF="$HOME/.config/waybar/config.jsonc"

		    if ! lsmod | grep -q '^k10temp'; then
  		      sudo modprobe k10temp
		    fi

		    hwmon_path=""
		    for hw in /sys/class/hwmon/hwmon*; do
  		      if [[ -r "$hw/name" ]]; then
    		        name=$(< "$hw/name")
    		        if [[ "$name" == "k10temp" || "$name" == "coretemp" ]]; then
      		          hwmon_path="$hw"
      		          break
    		        fi
  		      fi
		    done

		    if [[ -z "$hwmon_path" ]]; then
  		      echo "Error: k10temp/coretemp hwmon not found"
  		      exit 1
		    fi

		    full_path="${hwmon_path}/temp1_input"
		    echo "k10temp/coretemp found at: $full_path"

		    sed -i.bak -E "s|^([[:space:]]*)//?[[:space:]]*(\"hwmon-path\"[[:space:]]*:[[:space:]]*\")[^\"]*(\")|\1\2${full_path}\3|" "$WAYBAR_CONF"

		    killall waybar 2>/dev/null || true
		    if command -v waybar &> /dev/null; then
  		      nohup waybar > /dev/null 2>&1 &
		    fi
		    ;;
		"Manual Config")
		    nvim ~/.config/waybar/config.jsonc
		    ;;
		"Back ")
		    gum confirm "Press enter to return to menu." && exec "$0"
	 	    ;;
	    esac
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
