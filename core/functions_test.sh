#!/bin/bash

source ./core/packages.sh

LOG_DIR="${XDG_DATA_HOME:-$HOME/.local/share}/hyprnosis/logs"
LOG_PATH="$LOG_DIR/hyprnosis.log"

_has_gum() {
    command -v gum &> /dev/null
}

ensure_gum() {
    if ! is_installed "gum"; then
        echo "Installing gum for better UI..."
        sudo pacman -S --noconfirm gum
    fi
}

log_header() {
    local text="$1"
    echo
    gum style \
        --foreground 108 \
        --border double \
        --border-foreground 108 \
        --padding "0 2" \
        --margin "1 0" \
        --width 50 \
        --align center \
        "$text"
    echo
}

log_step() {
    local text="$1"
    gum style --foreground 108 --bold "▸ $text"
}

log_info() {
    local text="$1"
    gum style --foreground 246 "→ $text"
}

log_success() {
    local text="$1"
    gum style --foreground 108 "✓ $text"
}

log_error() {
    local text="$1"
    gum style --foreground 196 --bold "✗ $text"
}

log_detail() {
    local text="$1"
    gum style --foreground 241 "  › $text"
}

spinner() {
    local title="$1"
    shift
    gum spin --spinner dot --title "$title" --show-error -- "$@"
}

ask_yes_no() {
    local prompt="$1"
    gum confirm "$prompt" && return 0 || return 1
}

create_log() {
    mkdir -p "$LOG_DIR"
    touch "$LOG_PATH"
}

install_yay() {
    spinner "Installing git and base-devel" sudo pacman -S --noconfirm git base-devel
    rm -rf yay
    spinner "Cloning yay AUR helper" git clone https://aur.archlinux.org/yay.git
    cd yay || return
    spinner "Building and installing yay" makepkg -si --noconfirm
    cd ..
    rm -rf yay
    log_success "yay installed"
}

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

enable_user_service() {
    local svc="$1"
    if systemctl --user list-unit-files | grep -q "^${svc}"; then
        if systemctl --user enable --now "$svc"; then
            log_success "Enabled and started $svc"
        else
            log_error "Failed to enable/start $svc"
        fi
    else
        log_error "Service $svc not found, skipping enable/start"
    fi
}

enable_service() {
    local service=$1
    log_info "Enabling $service..."
    if systemctl list-unit-files | grep -q "^${service}"; then
        spinner "Starting $service" sudo systemctl start "$service"
        spinner "Enabling $service at boot" sudo systemctl enable "$service"
        log_success "$service enabled"
    else
        log_error "Service '$service' not found, skipping."
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
    log_success "Enabled systemd autologin for user: $H_USERNAME"
}

install_gpu_packages() {
    local GPU_CHOICE
    GPU_CHOICE=$(gum choose "AMD" "NVIDIA" "Skip")
    case "$GPU_CHOICE" in
        AMD)
            log_info "Installing AMD GPU packages..."
            install_packages "${amd_packages[@]}"
            ;;
        NVIDIA)
            log_info "Installing NVIDIA GPU packages..."
            install_packages "${nvidia_packages[@]}"
            ;;
        Skip)
            log_info "Skipping GPU package installation."
            ;;
    esac
}

config_setup() {
    spinner "Copying Hyprnosis theme files" cp -r "$HOME/.config/hyprnosis/themes/Hyprnosis/." "$HOME/.config/"
    spinner "Copying config files" cp -r "$HOME/.config/hyprnosis/config/"* "$HOME/.config/"
    spinner "Cloning wallpapers repo" git clone --depth 1 https://github.com/tyvren/hyprnosis-wallpapers.git /tmp/wallpapers
    spinner "Copying wallpapers" cp -r /tmp/wallpapers/. "$HOME/.config/hyprnosis/wallpapers/"
    rm -rf /tmp/wallpapers
    chmod +x "$HOME/.config/hyprnosis/modules/"*
    log_success "Configuration setup complete"
}

get_username() {
    H_USERNAME=$(gum input --placeholder "Enter your username for Hyprland login")
    while [[ -z "$H_USERNAME" ]]; do
        gum style --foreground 196 "Username cannot be empty. Please enter a valid username."
        H_USERNAME=$(gum input --placeholder "Enter your username for Hyprland login")
    done
    log_info "Username set to $H_USERNAME"
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
EOF
)
    if ! grep -q "$FUNCTION_NAME()" "$SHELL_RC"; then
        echo "$FUNCTION_DEF" >> "$SHELL_RC"
        log_success "Alias function '$FUNCTION_NAME' added to $SHELL_RC"
    else
        log_info "Function '$FUNCTION_NAME' already exists in $SHELL_RC"
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
        cat > "$path" <<EOF
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
    spinner "Installing Plymouth theme" sudo cp -r "$HOME/.config/hyprnosis/config/plymouth/themes/hyprnosis" "/usr/share/plymouth/themes/"
    sudo plymouth-set-default-theme -R hyprnosis
    for entry in /boot/loader/entries/*.conf; do
        [[ "$entry" == *"-fallback.conf" ]] && continue
        sudo sed -i '/^options/ s/$/ quiet splash/' "$entry"
    done
    log_success "Plymouth configured"
}

cursor_symlinks() {
    mkdir -p ~/.icons
    for theme in /usr/share/icons/catppuccin-mocha-*-cursors; do
        name=$(basename "$theme")
        if [[ ! -e "$HOME/.icons/$name" ]]; then
            ln -s "$theme" "$HOME/.icons/$name"
            log_info "Linked cursor theme: $name"
        fi
    done
}

