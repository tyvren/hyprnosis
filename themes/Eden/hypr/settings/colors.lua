local moon = "rgb(feffff)"
local moon_alpha = "rgba(feffffff)"
local ocean = "rgb(12161f)"
local ocean_alpha = "rgba(12161fff)"
local surface = "rgb(D1CDC2)"
local black = "rgb(0D0D0D)"

hl.config({
	general = {
		col = {
			active_border = { colors = { surface, moon }, angle = 45 },
			inactive_border = "rgba(80808020)",
		},
	},
})
