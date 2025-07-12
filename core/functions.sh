#!/bin/bash

source ./core/packages.sh

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
    echo "Installing package: $pkg"
    if ! yay -S --noconfirm --needed "$pkg"; then
      echo "Warning: Failed to install package $pkg. Continuing..."
    fi
  done
}

enable_user_service() {
  local svc="$1"
  if systemctl --user list-unit-files | grep -q "^${svc}"; then
    if systemctl --user enable --now "$svc"; then
      echo "Enabled and started $svc"
    else
      echo "Warning: Failed to enable/start $svc"
    fi
  else
    echo "Warning: Service $svc not found, skipping enable/start"
  fi
}

enable_service() {
  local service=$1
  echo "Enabling $service..."

  if systemctl list-unit-files | grep -q "^${service}"; then
    if sudo systemctl start "$service"; then
      echo "Started $service"
    else
      echo "Failed to start $service"
    fi

    if sudo systemctl enable "$service"; then
      echo "Enabled $service to start at boot"
    else
      echo "Failed to enable $service"
    fi
  else
    echo "Service '$service' not found. Skipping."
  fi
  echo
}

hyprland_autologin() {
  enable_user_service "waybar.service"

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
  echo "Enabled systemd autologin for user: $H_USERNAME"
}

install_gpu_driver() {
while true; do
  echo "Select a GPU Driver to install:"
  echo "  1) AMD"
  echo "  2) NVIDIA"
  echo "  3) Skip"
  echo -n "Enter 1, 2, or 3: "
  read -r GPU_CHOICE

  case "$GPU_CHOICE" in
    1)
      echo "Installing AMD GPU drivers..."
      sudo pacman -S --needed mesa lib32-mesa vulkan-radeon
      break
      ;;
    2)
      echo "Installing NVIDIA GPU drivers..."
      sudo pacman -S --needed nvidia nvidia-utils lib32-nvidia-utils vulkan-icd-loader lib32-vulkan-icd-loader
      break
      ;;
    3)
      echo "Skipping GPU driver installation."
      break
      ;;
    *)
      echo "Invalid choice. Please enter 1, 2, or 3."
      ;;
  esac
done
}

detect_sensors() {
  echo "Running fan and thermal sensor detection (lm_sensors)"
  read -rp "This will prompt for several yes/no hardware questions. Run now? [y/N]: " run_sensors
  if [[ "$run_sensors" =~ ^[Yy]$ ]]; then
    sudo sensors-detect
  else
    echo "Skipped sensors-detect."
  fi
}

config_setup() {
#Copy config files to the user's home directory
  cp -r "$HOME/.config/hyprnosis/themes/Default/." "$HOME/.config/"
  cp -r "$HOME/.config/hyprnosis/configs/hypr/." "$HOME/.config/hypr/"
  cp -r "$HOME/.config/hyprnosis/configs/nvim/." "$HOME/.config/nvim/"
  cp -r "$HOME/.config/hyprnosis/configs/waybar/." "$HOME/.config/waybar/"
#Clone wallpaper repo
  git clone --depth 1 https://github.com/steve-conrad/hyprnosis-wallpapers.git /tmp/wallpapers && \
  cp -r /tmp/wallpapers/. "$HOME/.config/hyprnosis/wallpapers/" && \
  rm -rf /tmp/wallpapers
#Make modules executable
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
