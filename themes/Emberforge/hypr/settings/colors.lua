local neon_orange = "rgb(fe4f00)"
local neon_orange_dim = "rgb(402015)"
local gunmetal = "rgb(626262)"
local gunmetal_dim = "rgb(2e2e2e)"
local white = "rgb(ffffff)"
local gray_light = "rgb(b4b4b4)"

hl.config({
	general = {
		col = {
			active_border = { colors = { neon_orange, neon_orange }, angle = 45 },
			inactive_border = neon_orange,
		},
	},
	decoration = {
		glow = {
			enabled = true,
			color = neon_orange,
			range = 8,
		},
	},
})
