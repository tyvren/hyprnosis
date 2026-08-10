local crimson = "rgb(ac2f52)"
local heart = "rgb(8a3663)"
local ash = "rgb(a7a8ac)"
local granite = "rgb(49494d)"

hl.config({
	general = {
		col = {
			active_border = { colors = { heart, ash }, angle = 45 },
			inactive_border = granite,
		},
	},
	decoration = {
		glow = {
			enabled = false,
			color = ash,
			range = 8,
		},
	},
})
