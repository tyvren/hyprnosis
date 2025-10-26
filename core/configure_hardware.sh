#!/bin/bash

source ./core/packages.sh
source ./core/functions.sh

configure_hardware_type() {
    if ls /sys/class/power_supply/BAT* >/dev/null 2>&1 || [ -d /sys/class/power_supply/battery ]; then
        log_info "Laptop detected, installing required packages..."
	install_packages "${laptop_packages[@]}" 
    else
        log_info "Desktop detected, no additional packages to install."
    fi
}

configure_gpu() {
    log_info "Checking for installed GPUs..."
    if  lspci | grep -i nvidia ; then
	log_info "Nvidia detected, installing required packages..."
	install_packages "${nvidia_packages[@]}"
    elif lspci  | grep -i AMD ; then
	log_info "AMD GPU detected, installing required packages..."
	install_packages "${amd_packages[@]}"
    else
	log_info "No dedicated GPU detected, skipping..."
    fi
}
