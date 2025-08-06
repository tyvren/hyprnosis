**hyprnosis - a hyprland offering - setup script and full configuration for hyprland on arch linux**

########
Features
########

- Built for Desktops with pre-loaded system monitoring and overclocking tools
- AMD or NVidia GPU drivers
- Steam, Discord, Coolercontrol, OCCT
- A fully configured, simple and easy to build from hyprland desktop environment
- Theme switching script with 6 themes, including some inspired by my favorite band

- Waybar - status bar
- Wofi - power menu, bluetooth menu, and app launcher 
- NVIM - preconfigured neovim plugins and themes

##########
QuickStart
##########

Detailed documentation can be found in the wiki.

**Dependencies** - multilib repository - add this to your archinstall before running

After logging into your new Arch system, run the following:

    bash <(curl -sL https://raw.githubusercontent.com/steve-conrad/hyprnosis/main/boot.sh)

- Enter your sudo password when prompted

- Follow the script's interactive prompts (e.g GPU driver selection, Hyprland auto-login and additional sudo prompts)

The script installs all required packages and applies the hyprnosis configuration
