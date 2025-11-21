get_username() {
  while true; do
    H_USERNAME=$(gum input --placeholder "Enter your Arch username to configure Hyprland login")

    while [[ -z "$H_USERNAME" ]]; do
      gum style --foreground 37 "Username cannot be empty. Please enter a valid username."
      H_USERNAME=$(gum input --placeholder "Enter your Arch username to configure Hyprland login")
    done

    CONFIRM=$(gum input --placeholder "Re-enter your Arch username to confirm")

    if [[ "$H_USERNAME" == "$CONFIRM" ]]; then
      log_info "Username set to $H_USERNAME"
      break
    else
      gum style --foreground 37 "Usernames do not match. Please try again."
    fi
  done
}

hyprland_autologin() {
  local BASH_PROFILE="$HOME/.bash_profile"
  grep -q "uwsm check may-start" "$BASH_PROFILE" || cat >>"$BASH_PROFILE" <<'EOF'

# Start Hyprland via uwsm if available
if uwsm check may-start; then
  exec uwsm start hyprland.desktop
fi
EOF

  sudo mkdir -p /etc/systemd/system/getty@tty1.service.d
  sudo tee /etc/systemd/system/getty@tty1.service.d/override.conf >/dev/null <<EOF
[Service]
ExecStart=
ExecStart=-/usr/bin/agetty --autologin "$H_USERNAME" --noclear %I \$TERM
EOF

  sudo systemctl daemon-reexec
  log_success "Enabled systemd autologin for user: $H_USERNAME"
}
