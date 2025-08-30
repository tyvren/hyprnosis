#!/bin/bash

menu() {
  local prompt="$1"
  local options="$2"
  local extra="$3"
  local preselect="$4"

  read -r -a args <<<"$extra"

  if [[ -n "$preselect" ]]; then
    local index
    index=$(echo -e "$options" | grep -nxF "$preselect" | cut -d: -f1)
    if [[ -n "$index" ]]; then
      args+=("-a" "$index")
    fi
  fi

  echo -e "$options" | walker --dmenu -p "$prompt…" "${args[@]}"
}

terminal() {
  ghostty -e "$@"
}

present_terminal() {
    ghostty -e bash -c "$1"
}

edit_in_nvim() {
  notify-send "Editing config file" "$1"
  ghostty -e nvim "$1"
}

install() {
  present_terminal "echo 'Installing $1...'; sudo pacman -Sy --noconfirm $2"
}

install_and_launch() {
  present_terminal "echo 'Installing $1...'; sudo pacman -Sy --noconfirm $2 && setsid gtk-launch $3"
}

install_font() {
  present_terminal "echo 'Installing $1...'; sudo pacman -Sy --noconfirm --needed $2 && sleep 2 && omarchy-font-set '$3'"
}

aur_install() {
  present_terminal "echo 'Installing $1 from AUR...'; yay -Sy --noconfirm $2"
}

aur_install_and_launch() {
  present_terminal "echo 'Installing $1 from AUR...'; yay -Sy --noconfirm $2 && setsid gtk-launch $3"
}

show_power_menu() {
  case $(menu "Power" " Shutdown\n Restart\n Lock") in
    *Shutdown*) systemctl poweroff ;;
    *Restart*) systemctl reboot ;;
    *Lock*) hyprlock ;;
    *) show_main_menu ;;
  esac
}

show_packages_menu() {
  case $(menu "Packages" "Install Arch Package\nInstall AUR Package\nUninstall Package") in
    *Arch*) ghostty -e ~/.config/hyprnosis/modules/pkg_install.sh ;;
    *AUR*) ghostty -e ~/.config/hyprnosis/modules/pkg_aur_install.sh ;;
    *Uninstall*) ghostty -e ~/.config/hyprnosis/modules/pkg_uninstall.sh ;;  
    *) show_main_menu ;;
  esac
}

show_learn_menu() {
  case $(menu "Learn" "  Keybindings\n  Hyprnosis\n  Hyprland\n󰣇  Arch\n  Neovim\n󱆃  Bash") in
    *Keybindings*) exec ~/.config/hyprnosis/modules/hyprnosis_menu_keybinds.sh ;;
    *Hyprnosis*) firefox "https://github.com/steve-conrad/hyprnosis/wiki" ;;
    *Hyprland*) firefox "https://wiki.hypr.land/" ;;
    *Arch*) firefox "https://wiki.archlinux.org/title/Main_page" ;;
    *Neovim*) firefox "https://www.lazyvim.org/keymaps" ;;
    *Bash*) firefox "https://devhints.io/bash" ;;
    *) show_main_menu ;;
  esac
}

show_main_menu() {
  go_to_menu "$(menu "Main Menu" " Apps\n Power\n Update\n Packages\n Theme\n  Learn\n About")"
}

go_to_menu() {
  case "${1,,}" in
    *apps*) walker -p "Launch…" ;;
    *power*) show_power_menu ;;
    *update*) terminal bash -c ~/.config/hyprnosis/modules/hyprnosis_update_tui.sh ;;
    *packages*) show_packages_menu ;;
    *theme*) exec ~/.config/hyprnosis/modules/theme_changer.sh ;;
    *learn*) show_learn_menu ;;
    *about*) terminal bash -c 'fastfetch; read -n 1 -s' ;;
  esac
}

if [[ -n "$1" ]]; then
  go_to_menu "$1"
else
  show_main_menu
fi
