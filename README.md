
<img width="3825" height="1518" alt="hyprnosis_banner" src="https://github.com/user-attachments/assets/66b5b537-8012-4dc3-acbc-162e3d3d2a11" />

**hyprnosis - a hyprland offering - setup script and full configuration for arch linux**
-----------------------------------------------------------------------

<img width="3840" height="2160" alt="2026-01-31-162543_hyprshot" src="https://github.com/user-attachments/assets/8b8c40f7-2bb9-448b-9abc-0587b6620155" />

**Features**

- A fully configured hyprland environment built with quickshell
- AMD or NVidia GPU packages installed automatically during setup
- Minimal pre-installed packages
- NVIM - preconfigured neovim plugins and themes using lazyvim
- Theme switching with multiple preinstalled themes

**The full list of pre-installed packages can be found under /core/packages.sh**

----------------------------------------------------------------------

**Desktop Environment**
- Quickshell

----------------------------------------------------------------------

**QuickStart**
Detailed documentation can be found in the wiki.

**Dependencies** 
- multilib repository, pipewire and network manager must be added during arch install.
- Secure boot must be disabled in UEFI for systemd bootloader use.

**This script is meant to be used as an automated setup for new arch systems. Clean installs are recommended, as I can not guarantee the functionality when applied to a pre-configured system.**

After logging into your new Arch system, run the following command to start the setup:

    bash <(curl -sL https://raw.githubusercontent.com/tyvren/hyprnosis/main/boot.sh)

- Enter your password when prompted

- Follow the remaining steps in the installer to automatically configure your hyprland login and download required packages
