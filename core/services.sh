enable_user_service() {
  local svc="$1"
  log_info "Enabling $svc..."
  if systemctl --user list-unit-files | grep -q "^${svc}"; then
    spinner "Enabling $svc" systemctl --user enable "$svc" || log_error "Failed to enable $svc"
    spinner "Starting $svc" systemctl --user start "$svc" || log_error "Failed to start $svc"
    log_success "$svc enabled"
  else
    log_error "Service $svc not found, skipping."
  fi
}

enable_service() {
  local svc="$1"
  log_info "Enabling $svc..."
  if systemctl list-unit-files | grep -q "^${svc}"; then
    spinner "Enabling $svc" sudo systemctl enable "$svc" || log_error "Failed to enable $svc"
    spinner "Starting $svc" sudo systemctl start "$svc" || log_error "Failed to start $svc"
    log_success "$svc enabled"
  else
    log_info "Service '$svc' not found, skipping."
  fi
}

enable_plymouth() {
  spinner "Installing bootloader logo..." sudo cp -r "$HOME/.config/hyprnosis/config/plymouth/themes/hyprnosis" "/usr/share/plymouth/themes/"
  sudo plymouth-set-default-theme -R hyprnosis
  for entry in /boot/loader/entries/*.conf; do
    [[ "$entry" == *"-fallback.conf" ]] && continue
    sudo sed -i '/^options/ s/$/ quiet splash/' "$entry"
  done
  log_success "hyprnosis bootloader logo configured"
}

enable_iwd() {
  sudo tee /etc/NetworkManager/conf.d/wifi_backend.conf >/dev/null <<'EOF'
[device]
wifi.backend=iwd
EOF
}
