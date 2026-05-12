require("settings.autostart")
require("settings.environment-variables")
require("settings.input")
require("settings.keybinds")
require("settings.look-and-feel")
require("settings.monitors")
require("settings.permissions")
require("settings.windows-and-workspaces")

----------------
----  MISC  ----
----------------

hl.config({
	misc = {
		force_default_wallpaper = -1, -- Set to 0 or 1 to disable the anime mascot wallpapers
		disable_hyprland_logo = false, -- If true disables the random hyprland logo / anime girl background. :(
	},
})
