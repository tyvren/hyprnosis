local bg = "rgba(000000b3)"
local text = "rgb(d0d0d0)"
local select = "rgb(404040)"
local hilight = "rgb(ffffff)"
local accent = "rgba(ffffff80)"
local muted = "rgb(606060)"
local transb = "rgba(00000080)"

hl.config({
	general = {
		col = {
			active_border = { colors = { hilight, accent }, angle = 45 },
			inactive_border = transb,
		},
	},
})
