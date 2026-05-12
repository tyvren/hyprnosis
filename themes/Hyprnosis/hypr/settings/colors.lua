local blue = "rgb(01A2FC)"
local blue_alpha = "rgba(1868c1b3)"
local blue_dim_alpha = "rgba(1868c11a)"
local gray_blue = "rgb(7faecc)"
local gray_blue_alpha = "rgba(7faeccb3)"
local gray_blue_dim = "rgba(7faecc1a)"
local white = "rgb(fafafa)"
local white_alpha = "rgba(fafafae6)"
local white_dim = "rgba(fafafa33)"
local black = "rgb(000002)"
local black_alpha = "rgba(00000280)"

hl.config({
	general = {
		col = {
			active_border = { colors = { blue, gray_blue }, angle = 45 },
			inactive_border = gray_blue_alpha,
		},
	},
})
