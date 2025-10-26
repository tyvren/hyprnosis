#!/bin/bash

source ./core/packages.sh

LOG_DIR="${XDG_DATA_HOME:-$HOME/.local/share}/hyprnosis/logs"
LOG_PATH="$LOG_DIR/hyprnosis.log"

_ICON_STEP="▸"
_ICON_INFO="→"
_ICON_SUCCESS="✓"
_ICON_ERROR="✗"

is_installed() {
    pacman -Q "$1" &>/dev/null
}

ensure_gum() {
    if ! is_installed "gum"; then 
        sudo pacman -S --noconfirm gum
    fi
}

header() {
    local text="$1"
    echo
    gum style \
        --foreground 37 \
        --border double \
        --border-foreground 69 \
        --padding "0 2" \
        --margin "1 0" \
        --width 50 \
        --align center \
        "$text"
    echo
}

log_step() {
    clear
    header "hyprnosis"
    local text="$1"
    gum style --foreground 99 --bold "$_ICON_STEP $text" | tee -a "$LOG_PATH" 
}

log_info() {
    local text="$1"
    gum style --foreground 69 "  $_ICON_INFO $text"   
}

log_success() {
    local text="$1"
    gum style --foreground 37 "  $_ICON_SUCCESS $text" | tee -a "$LOG_PATH" 
}

log_error() {
    local text="$1"
    gum style --foreground 19 --bold "  $_ICON_ERROR $text" | tee -a "$LOG_PATH" 
}

spinner() {
    local title="$1"
    shift
    gum spin --spinner dot --title "$title" --show-error -- "$@" </dev/tty >/dev/null 2>&1
}

prompt_yes_no() {
    local prompt="$1"
    gum confirm "$prompt" && return 0 || return 1
}

create_log() {
    mkdir -p "$LOG_DIR"
    touch "$LOG_PATH"
}

install_yay() {
    log_info "Installing git and base-devel..." 
    sudo pacman -S --noconfirm git base-devel
    rm -rf yay
    log_info "Cloning yay AUR helper..." 
    git clone https://aur.archlinux.org/yay.git
    cd yay || return
    log_info "Building and installing yay..." 
    makepkg -si --noconfirm
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


