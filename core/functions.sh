#!/bin/bash

source ./core/packages.sh

LOG_DIR="${XDG_DATA_HOME:-$HOME/.local/share}/hyprnosis/logs"
LOG_PATH="$LOG_DIR/hyprnosis.log"

_BLUE='\033[0;34m'
_CYAN='\033[0;36m'
_PURPLE='\033[0;35m'
_NC='\033[0m'

_ICON_STEP="▸"
_ICON_INFO="→"
_ICON_SUCCESS="✓"
_ICON_ERROR="✗"
_ICON_ARROW="›"

_has_gum() {
    command -v gum &> /dev/null
}

is_installed() {
    pacman -Q "$1" &>/dev/null
}

ensure_gum() {
    if ! is_installed "gum"; then 
        sudo pacman -S --noconfirm gum
    fi
}

log_header() {
    local text="$1"
    if _has_gum; then
        echo
        gum style \
            --foreground 55 \
            --border double \
            --border-foreground 69 \
            --padding "0 2" \
            --margin "1 0" \
            --width 50 \
            --align center \
            "$text"
        echo
    else
        echo -e "\n${_PURPLE}════════════════════════════════════════${_NC}"
        echo -e "${_BLUE}  $text${_NC}"
        echo -e "${_PURPLE}════════════════════════════════════════${_NC}\n"
    fi
}

log_step() {
    clear
    log_header "hyprnosis"
    local text="$1"

    if _has_gum; then
        gum style --foreground 99 --bold "$_ICON_STEP $text" >> "$LOG_PATH" 
    else
        echo -e "\n${_BLUE}$_ICON_STEP${_NC} $text" >> "$LOG_PATH"
    fi
}

log_info() {
    local text="$1"

    if _has_gum; then
        gum style --foreground 69 "  $_ICON_INFO $text"  
    else
        echo -e "  ${_CYAN}$_ICON_INFO${_NC} $text" 
    fi
}

log_success() {
    local text="$1"

    if _has_gum; then
        gum style --foreground 37 "  $_ICON_SUCCESS $text" 
    else
        echo -e "  ${_PURPLE}$_ICON_SUCCESS${_NC} $text" 
    fi
}

log_error() {
    local text="$1"

    if _has_gum; then
        gum style --foreground 19 --bold "  $_ICON_ERROR $text" 
    else
        echo -e "  ${_CYAN}$_ICON_ERROR${_NC} $text" 
    fi
}

log_detail() {
    local text="$1"

    if _has_gum; then
        gum style --foreground 244 "    $_ICON_ARROW $text" 
    else
        echo -e "    ${_CYAN}$_ICON_ARROW${_NC} $text" 
    fi
}


spinner() {
    local title="$1"
    shift

    if _has_gum; then
        gum spin --spinner dot --title "$title" --show-error -- "$@" </dev/tty >/dev/null 2>&1
    else
        echo -e "${_CYAN}⟳${_NC} $title"
        "$@" </dev/tty >/dev/null 2>&1
    fi
}

ask_yes_no() {
    local prompt="$1"

    if _has_gum; then
        gum confirm "$prompt" && return 0 || return 1
    else
        while true; do
            read -rp "$prompt [y/n]: " yn
            case $yn in
                [Yy]*) return 0 ;;
                [Nn]*) return 1 ;;
                *) echo "Please answer yes or no." ;;
            esac
        done
    fi
}

create_log() {
    mkdir -p "$LOG_DIR"
    touch "$LOG_PATH"
}

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
    local svc="$1"
    log_info "Enabling $svc..."
    if systemctl list-unit-files | grep -q "^${svc}"; then
        spinner "Starting $svc" sudo systemctl start "$svc" || log_error "Failed to start $svc"
        spinner "Enabling $svc at boot" sudo systemctl enable "$svc" || log_error "Failed to enable $svc"
        log_success "$svc enabled"
    else
        log_info "Service '$svc' not found, skipping."
    fi
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
    sudo systemctl restart getty@tty1
    log_success "Enabled systemd autologin for user: $H_USERNAME"
}

install_gpu_packages() {
    local GPU_CHOICE
    GPU_CHOICE=$(_has_gum && gum choose "AMD" "NVIDIA" "Skip" || echo "Skip")
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
    spinner "Copying Hyprnosis theme files..." cp -r "$HOME/.config/hyprnosis/themes/Hyprnosis/." "$HOME/.config/"
    spinner "Copying config files..." cp -r "$HOME/.config/hyprnosis/config/"* "$HOME/.config/"
    spinner "Cloning wallpapers repo..." git clone --depth 1 https://github.com/tyvren/hyprnosis-wallpapers.git /tmp/wallpapers
    spinner "Copying wallpapers..." cp -r /tmp/wallpapers/. "$HOME/.config/hyprnosis/wallpapers/"
    rm -rf /tmp/wallpapers
    chmod +x "$HOME/.config/hyprnosis/modules/"*
    log_success "Configuration setup complete"
}

get_username() {
    H_USERNAME=$(gum input --placeholder "Enter your username for Hyprland login")
    while [[ -z "$H_USERNAME" ]]; do
        gum style --foreground 55 "Username cannot be empty. Please enter a valid username."
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
