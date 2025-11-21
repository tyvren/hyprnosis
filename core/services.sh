enable_user_service() {
  local svc="$1"
  log_info "Enabling $svc..."
  if systemctl --user list-unit-files | grep -q "^${svc}"; then
    spinner "Enabling $svc" sudo systemctl --user enable "$svc" || log_error "Failed to enable $svc"
    spinner "Starting $svc" sudo systemctl --user start "$svc" || log_error "Failed to start $svc"
    log_success "$svc enabled"
  else
    log_error "Service $svc not found, skipping."
  fi
}

enable_service() {
  local svc="$1"
  log_info "Enabling $svc..."
  if systemctl list-unit-files | grep -q "^${svc}"; then
    spinner "Enabling $svc" systemctl enable "$svc" || log_error "Failed to enable $svc"
    spinner "Starting $svc" systemctl start "$svc" || log_error "Failed to start $svc"
    log_success "$svc enabled"
  else
    log_info "Service '$svc' not found, skipping."
  fi
}

enable_elephant_service() {
  elephant service enable
  systemctl --user start elephant.service
  log_success "Enabled and started elephant.service"
}

enable_walker_service() {
  local svc="walker.service"
  local path="$HOME/.config/systemd/user/$svc"

  if [[ ! -f "$path" ]]; then
    cat >"$path" <<EOF
[Unit]
Description=Walker GApplication Service

[Service]
ExecStart=/usr/bin/walker --gapplication-service
Restart=always

[Install]
WantedBy=default.target
EOF
    log_info "Created $svc at $path"
  fi

  systemctl --user daemon-reload
  if systemctl --user enable --now "$svc"; then
    log_success "Enabled and started $svc"
  else
    log_error "Failed to enable/start $svc"
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
