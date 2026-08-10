local bg = "rgb(08110B)"
local text = "rgb(d0d0d0)"
local select = "rgb(404040)"
local hilight = "rgb(ffffff)"
local accent = "rgb(50AF73)"
local muted = "rgb(163120)"
local transb = "rgba(00000080)"

hl.config({
	general = {
		col = {
			active_border = { colors = { accent, bg }, angle = 45 },
			inactive_border = bg,
		},
	},
	decoration = {
		glow = {
			enabled = false,
			color = hilight,
			range = 8,
		},
	},
})
