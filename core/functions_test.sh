#!/bin/bash

source ./core/packages.sh

LOG_DIR="${XDG_DATA_HOME:-$HOME/.local/share}/hyprnosis/logs"
LOG_PATH="$LOG_DIR/hyprnosis.log"

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
        echo "Installing gum for better UI..."
        sudo pacman -S --noconfirm gum
    fi
}

log_header() {
    clear
    if _has_gum; then
        gum style \
            --foreground 99 \
            --border-foreground 120 \
            --border double \
            --align center \
            --width 50 \
            --margin "1 2" \
            --padding "2 4" \
            "Hyprnosis"
        echo
    else
        echo "==== Hyprnosis ===="
    fi
}

log_step() {
    local text="$1"
    if _has_gum; then
        gum style --foreground 99 --bold "$_ICON_STEP $text"
    else
        echo "$_ICON_STEP $text"
    fi
}

log_info() {
    local text="$1"
    if _has_gum; then
        gum style --foreground 99 "  $_ICON_INFO $text"
    else
        echo "  -> $text"
    fi
}

log_success() {
    local text="$1"
    if _has_gum; then
        gum style --foreground 120 "  $_ICON_SUCCESS $text"
    else
        echo "  [OK] $text"
    fi
}

log_error() {
    local text="$1"
    if _has_gum; then
        gum style --foreground 196 --bold "  $_ICON_ERROR $text"
    else
        echo "  [ERROR] $text"
    fi
}

log_detail() {
    local text="$1"
    if _has_gum; then
        gum style --foreground 241 "    $_ICON_ARROW $text"
    else
        echo "    -> $text"
    fi
}

spinner() {
    local title="$1"
    shift
    if _has_gum; then
        gum spin --spinner dot --title "$title" --show-error -- "$@" </dev/tty >/dev/null 2>&1
    else
        echo "⟳ $title"
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
        if ! spinner "Installing $pkg..." yay -S --noconfirm --needed "$pkg"; then
            log_error "Failed to install package $pkg"
        else
            log_success "$pkg installed"
        fi
    done
}

enable_service() {
    local svc="$1"
    if systemctl list-unit-files | grep -q "^${svc}"; then
        spinner "Starting $svc" sudo systemctl start "$svc" || log_error "Failed to start $svc"
        spinner "Enabling $svc at boot" sudo systemctl enable "$svc" || log_error "Failed to enable $svc"
        log_success "$svc enabled"
    else
        log_info "Service '$svc' not found, skipping."
    fi
}

enable_user_service() {
    local svc="$1"
    if systemctl --user list-unit-files | grep -q "^${svc}"; then
        if systemctl --user enable --now "$svc"; then
            log_success "$svc started"
        else
            log_error "Failed to start $svc"
        fi
    else
        log_error "User service $svc not found, skipping"
    fi
}

install_gpu_packages() {
    local GPU_CHOICE
    GPU_CHOICE=$(_has_gum && gum choose "AMD" "NVIDIA" "Skip" || echo "Skip")
    case "$GPU_CHOICE" in
        AMD) install_packages "${amd_packages[@]}" ;;
        NVIDIA) install_packages "${nvidia_packages[@]}" ;;
        Skip) log_info "Skipping GPU package installation." ;;
    esac
}

get_username() {
    H_USERNAME=$(gum input --placeholder "Enter your username for Hyprland login")
    while [[ -z "$H_USERNAME" ]]; do
        gum style --foreground 196 "Username cannot be empty."
        H_USERNAME=$(gum input --placeholder "Enter your username for Hyprland login")
    done
    log_info "Username set to $H_USERNAME"
}

config_setup() {
    spinner "Copying theme files..." cp -r "$HOME/.config/hyprnosis/themes/Hyprnosis/." "$HOME/.config/"
    spinner "Copying config files..." cp -r "$HOME/.config/hyprnosis/config/"* "$HOME/.config/"
    spinner "Cloning wallpapers repo..." git clone --depth 1 https://github.com/tyvren/hyprnosis-wallpapers.git /tmp/wallpapers
    spinner "Copying wallpapers..." cp -r /tmp/wallpapers/. "$HOME/.config/hyprnosis/wallpapers/"
    rm -rf /tmp/wallpapers
    chmod +x "$HOME/.config/hyprnosis/modules/"*
    log_success "Configuration setup complete"
}

enable_coolercontrol() {
    sudo systemctl enable --now coolercontrold
    log_success "CoolerControl enabled"
}

setup_hyprnosis_alias() {
    SHELL_RC="$HOME/.bashrc"
    FUNCTION_NAME="hyprnosis"
    SCRIPT_PATH="$HOME/.config/hyprnosis/modules/hyprnosis_tui.sh"
    FUNCTION_DEF=$(cat <<EOF
$FUNCTION_NAME() {
    bash "$SCRIPT_PATH"
}
EOF
)
    if ! grep -q "$FUNCTION_NAME()" "$SHELL_RC"; then
        echo "$FUNCTION_DEF" >> "$SHELL_RC"
        log_success "Alias '$FUNCTION_NAME' added"
    else
        log_info "Alias '$FUNCTION_NAME' already exists"
    fi
}

enable_elephant_service() {
    elephant service enable
    systemctl --user start elephant.service
    log_success "Elephant service started"
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
        log_info "Created walker.service file"
    fi
    systemctl --user daemon-reload
    if systemctl --user enable --now "$svc"; then
        log_success "Walker service started"
    else
        log_error "Failed to start walker.service"
    fi
}

enable_plymouth() {
    spinner "Installing Plymouth theme..." sudo cp -r "$HOME/.config/hyprnosis/config/plymouth/themes/hyprnosis" "/usr/share/plymouth/themes/"
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

