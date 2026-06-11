local crimson = "rgb(ac2f52)"
local heart = "rgb(8a3663)"
local ash = "rgb(a7a8ac)"
local granite = "rgb(49494d)"

hl.config({
	general = {
		col = {
			active_border = { colors = { crimson, crimson }, angle = 45 },
			inactive_border = crimson,
		},
	},
	decoration = {
		glow = {
			enabled = true,
			color = crimson,
			range = 8,
		},
	},
})
