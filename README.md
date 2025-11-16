<img width="761" height="204" alt="hyprnosis" src="https://github.com/user-attachments/assets/25d6c010-0cec-4fae-bc0e-d9253c9fcee5" />

**A hyprland offering - setup script and full configuration for arch linux**
-----------------------------------------------------------------------

**Features**

- A fully configured hyprland environment
- AMD or NVidia GPU packages installed automatically during setup
- Steam, Discord, OCCT and other useful tools pre-installed
- NVIM - preconfigured neovim plugins and themes using lazyvim
- Theme switching with multiple preinstalled themes
- Helpful config scripts in the modules directory with predefined shortcuts

Check out the desktop environment themes in the wiki: https://github.com/tyvren/hyprnosis/wiki/themes

**The full list of preinstalled packages can be found under /core/packages.sh**

----------------------------------------------------------------------

**User Interface**
- Waybar - menu and status bar
- Walker - hyprnosis GUI menu system and app launcher

----------------------------------------------------------------------

**QuickStart**

Detailed documentation can be found in the wiki.

**Dependencies** 
- multilib repository, pipewire and network manager must be added during arch install.
- Secure boot must be disabled in UEFI for systemd bootloader use.

**This script is meant to be used as an automated setup for new arch systems. Clean installs only, as I can not guarantee the functionality when applied to a pre-configured system.**

After logging into your new Arch system, run the following command to start the setup:

    bash <(curl -sL https://raw.githubusercontent.com/tyvren/hyprnosis/main/boot.sh)

- Enter your password when prompted

- Follow the remaining steps in the installer to automatically configure your hyprland login and download required packages. 

Enjoy hyprland!
