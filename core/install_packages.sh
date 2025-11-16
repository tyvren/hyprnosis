install_packages() {
  local pkgs=("$@")
  for pkg in "${pkgs[@]}"; do
    log_info "Installing package: $pkg"
    if ! spinner "Installing $pkg..." yay -S --noconfirm --needed "$pkg"; then
      log_error "Failed to install package $pkg, continuing..."
    else
      log_success "$pkg installed"
    fi
  done
}
