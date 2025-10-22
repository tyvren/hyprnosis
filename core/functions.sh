#!/bin/bash

source ./core/packages.sh

LOG_DIR="${XDG_DATA_HOME:-$HOME/.local/share}/hyprnosis/logs"
LOG_PATH="$LOG_DIR/hyprnosis.log"

create_log() {
  mkdir -p "$LOG_DIR"
  touch "$LOG_PATH"
}

install_yay () {
  sudo pacman -S --noconfirm git base-devel --noconfirm
  rm -rf yay
  git clone https://aur.archlinux.org/yay.git
  cd yay
  makepkg -si --noconfirm
  cd ..
  rm -rf yay
}

install_packages() {
  local pkgs=("$@")
  for pkg in "${pkgs[@]}"; do
    echo "Installing package: $pkg" >> "$LOG_PATH"
    if ! yay -S --noconfirm --needed "$pkg"; then
      echo "Warning: Failed to install package $pkg. Continuing..." >> "$LOG_PATH"
    fi
  done
}

enable_user_service() {
  local svc="$1"
  if systemctl --user list-unit-files | grep -q "^${svc}"; then
    if systemctl --user enable --now "$svc"; then
      echo "Enabled and started $svc" >> "$LOG_PATH"
    else
      echo "Warning: Failed to enable/start $svc" >> "$LOG_PATH"
    fi
  else
    echo "Warning: Service $svc not found, skipping enable/start" >> "$LOG_PATH"
  fi
}

enable_service() {
  local service=$1
  echo "Enabling $service..." >> "$LOG_PATH"

  if systemctl list-unit-files | grep -q "^${service}"; then
    if sudo systemctl start "$service"; then
      echo "Started $service" >> "$LOG_PATH"
    else
      echo "Failed to start $service" >> "$LOG_PATH"
    fi

    if sudo systemctl enable "$service"; then
      echo "Enabled $service to start at boot" >> "$LOG_PATH"
    else
      echo "Failed to enable $service" >> "$LOG_PATH"
    fi
  else
    echo "Service '$service' not found. Skipping." >> "$LOG_PATH"
  fi
}

hyprland_autologin() {
  local BASH_PROFILE="$HOME/.bash_profile"
  grep -q "uwsm check may-start" "$BASH_PROFILE" || cat >> "$BASH_PROFILE" << 'EOF'

# Start Hyprland via uwsm if available
if uwsm check may-start; then
  exec uwsm start hyprland.desktop
fi
EOF

  sudo mkdir -p /etc/systemd/system/getty@tty1.service.d
  sudo tee /etc/systemd/system/getty@tty1.service.d/override.conf > /dev/null <<EOF
[Service]
ExecStart=
ExecStart=-/usr/bin/agetty --autologin "$H_USERNAME" --noclear %I \$TERM
EOF

  sudo systemctl daemon-reexec
  sudo systemctl restart getty@tty1
  echo "Enabled systemd autologin for user: $H_USERNAME" >> "$LOG_PATH"
}

install_gpu_packages() {
while true; do
  echo "Select your GPU type to install necessary packages:"
  echo "  1) AMD"
  echo "  2) NVIDIA"
  echo "  3) Skip"
  echo -n "Enter 1, 2, or 3: "
  read -r GPU_CHOICE

  case "$GPU_CHOICE" in
    1)
      echo "Installing AMD GPU packages..." >> "$LOG_PATH"
      install_packages "${amd_packages[@]}"
      break
      ;;
    2)
      echo "Installing NVIDIA GPU packages..." >> "$LOG_PATH"
      install_packages "${nvidia_packages[@]}"
      break
      ;;
    3)
      echo "Skipping GPU package installation." >> "$LOG_PATH"
      break
      ;;
    *)
      echo "Invalid choice. Please enter 1, 2, or 3."
      ;;
  esac
done
}

config_setup() {
  cp -r "$HOME/.config/hyprnosis/themes/Hyprnosis/." "$HOME/.config/"
  cp -r "$HOME/.config/hyprnosis/config/"* "$HOME/.config/"
  git clone --depth 1 https://github.com/tyvren/hyprnosis-wallpapers.git /tmp/wallpapers && \
  cp -r /tmp/wallpapers/. "$HOME/.config/hyprnosis/wallpapers/" && \
  rm -rf /tmp/wallpapers
  chmod +x "$HOME/.config/hyprnosis/modules/"*
}

get_username() {
  while true; do
    read -rp "Enter your username (Required for Hyprland login): " username1
    read -rp "Confirm username: " username2
    if [[ -z "$username1" ]]; then
      echo "Username cannot be empty."
    elif [[ "$username1" != "$username2" ]]; then
      echo "Usernames did not match. Please try again."
    else
      H_USERNAME="$username1"
      break
    fi
  done
}

enable_coolercontrol() {
  sudo systemctl enable --now coolercontrold
}

setup_hyprnosis_alias() {
    SHELL_RC="$HOME/.bashrc"
    FUNCTION_NAME="hyprnosis"
    SCRIPT_PATH="$HOME/.config/hyprnosis/modules/hyprnosis_tui.sh"
    FUNCTION_DEF=$(cat <<EOF
# hyprnosis CLI
$FUNCTION_NAME() {
    bash "$SCRIPT_PATH"
}
EOF)
  if ! grep -q "$FUNCTION_NAME()" "$SHELL_RC"; then
    echo "$FUNCTION_DEF" >> "$SHELL_RC"
    echo "Alias function '$FUNCTION_NAME' added to $SHELL_RC" >> "$LOG_PATH"
  else
    echo "Function '$FUNCTION_NAME' already exists in $SHELL_RC" >> "$LOG_PATH"
  fi
}

enable_elephant_service() {
  elephant service enable
  systemctl --user daemon-reload 
  systemctl --user start elephant.service
  systemctl --user restart elephant.service
  echo "[enable_elephant_service] Enabled and started elephant.service" >> "$LOG_PATH"
}

enable_walker_service() {
    local svc="walker.service"
    local path="$HOME/.config/systemd/user/$svc"

    if [[ ! -f "$path" ]]; then
        cat > "$path" <<EOF
[Unit]
Description=Walker GApplication Service

[Service]
ExecStart=/usr/bin/walker --gapplication-service
Restart=always

[Install]
WantedBy=default.target
EOF
        echo "[enable_walker_service] Created $svc at $path" >> "$LOG_PATH"
    fi

    systemctl --user daemon-reload

    if systemctl --user enable --now "$svc"; then
        echo "[enable_walker_service] Enabled and started $svc" >> "$LOG_PATH"
    else
        echo "[enable_walker_service] Failed to enable/start $svc" >> "$LOG_PATH"
    fi
}

enable_plymouth() {
  sudo cp -r "$HOME/.config/hyprnosis/config/plymouth/themes/hyprnosis" "/usr/share/plymouth/themes/"

  sudo plymouth-set-default-theme -R hyprnosis

  for entry in /boot/loader/entries/*.conf; do 
      [[ "$entry" == *"-fallback.conf" ]] && continue
      sudo sed -i '/^options/ s/$/ quiet splash/' "$entry"
  done
}

cursor_symlinks() {
  mkdir -p ~/.icons

  for theme in /usr/share/icons/catppuccin-mocha-*-cursors; do
      name=$(basename "$theme")
      if [[ ! -e "$HOME/.icons/$name" ]]; then
          ln -s "$theme" "$HOME/.icons/$name"
          echo "Linked $name"
      fi
  done
}
