**hyprnosis - a hyprland offering - setup script and full configuration for arch linux**

-----------------------------------------------------------------------

**Features**

- A fully configured and easy to use hyprland environment
- AMD or NVidia GPU packages installed during setup
- Steam, Discord, OCCT and many more preinstalled apps and tools
- NVIM - preconfigured neovim plugins and themes
- Theme switching script with multiple preinstalled themes, including some inspired by my favorite band

**The full list of preinstalled packages can be found under /core/packages.sh**

----------------------------------------------------------------------

**User Interface**
- Waybar - menu and status bar
- Walker - hyprnosis GUI menu system and app launcher

----------------------------------------------------------------------

**QuickStart**

Detailed documentation can be found in the wiki.

**Dependencies** 
- multilib repository must be added during arch install. Secure boot must be disabled in UEFI for systemd bootloader use.
- gum - used for the terminal UI installer aesthetic

**This script is meant to be used as an automated setup for new arch systems. Clean installs only, as I can not guarantee the functionality when applied to a pre-configured system.**

After logging into your new Arch system, run the following command to start the setup:

    bash <(curl -sL https://raw.githubusercontent.com/tyvren/hyprnosis/main/boot.sh)

- Enter your password when prompted

- Follow the remaining steps in the installer to automatically configure your hyprland login and download required packages. 

Enjoy hyprland!
