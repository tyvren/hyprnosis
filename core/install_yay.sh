install_yay() {
  spinner "Installing git and base-devel..." sudo pacman -S --noconfirm git base-devel
  rm -rf yay
  spinner "Cloning yay AUR helper..." git clone https://aur.archlinux.org/yay.git
  cd yay || return
  spinner "Building and installing yay..." makepkg -si --noconfirm
  cd ..
  rm -rf yay
  log_success "yay installed"
}
