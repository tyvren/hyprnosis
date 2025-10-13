**hyprnosis - a hyprland offering - setup script and full configuration for hyprland on arch linux**

-----------------------------------------------------------------------

**Features**

- A fully configured and easy to use hyprland environment
- AMD or NVidia GPU packages installed during setup
- Steam, Discord, OCCT
- System monitoring and overclocking tools
- Theme switching script with multiple preinstalled themes, including some inspired by my favorite band

- Waybar - menu and status bar
- Walker - hyprnosis GUI menu system and app launcher
- NVIM - preconfigured neovim plugins and themes

----------------------------------------------------------------------

**QuickStart**

Detailed documentation can be found in the wiki.

**Dependencies** - multilib repository must be added during arch install. Secure boot must be disabled in UEFI for systemd bootloader use.

**This script is meant to be used as an automated setup for new arch systems. Clean installs only, as I can not guarantee the functionality when applied to a pre-configured system**

After logging into your new Arch system, run the following:

    bash <(curl -sL https://raw.githubusercontent.com/tyvren/hyprnosis/main/boot.sh)

- Enter your sudo password when prompted

- Follow the script's interactive prompts (e.g GPU driver selection, Hyprland auto-login and additional sudo prompts)

The script installs all required packages and applies the hyprnosis configuration
