**hyprnosis - a hyprland offering - setup script and full configuration for hyprland on arch linux**

-----------------------------------------------------------------------

**Features**

- System monitoring and overclocking tools
- AMD or NVidia GPU packages installed during setup
- Steam, Discord, OCCT
- A fully configured, simple and easy to build from hyprland desktop environment
- Theme switching script with multiple preinstalled themes, including some inspired by my favorite band

- Waybar - status bar
- Walker - hyprnosis main menu system, app launcher, theme changer, and power menu
- NVIM - preconfigured neovim plugins and themes

----------------------------------------------------------------------

**QuickStart**

Detailed documentation can be found in the wiki.

**Dependencies** - multilib repository must be added during arch install. Secure boot must be disabled in UEFI for systemd bootloader use.

After logging into your new Arch system, run the following:

    bash <(curl -sL https://raw.githubusercontent.com/steve-conrad/hyprnosis/main/boot.sh)

- Enter your sudo password when prompted

- Follow the script's interactive prompts (e.g GPU driver selection, Hyprland auto-login and additional sudo prompts)

The script installs all required packages and applies the hyprnosis configuration
