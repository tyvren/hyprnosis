local background = "rgb(282A36)"
local foreground = "rgb(F8F8F2)"
local selection = "rgb(44475A)"
local comment = "rgb(6272A4)"
local red = "rgb(FF5555)"
local orange = "rgb(FFB86C)"
local yellow = "rgb(F1FA8C)"
local green = "rgb(50FA7B)"
local purple = "rgb(BD93F9)"
local cyan = "rgb(8BE9FD)"
local pink = "rgb(FF79C6)"

hl.config({
	general = {
		col = {
			active_border = { colors = { selection, purple }, angle = 90 },
			inactive_border = "rgba(44475aaa)",
			nogroup_border = "rgba(282a36dd)",
			nogroup_border_active = { colors = { purple, selection }, angle = 90 },
		},
	},
})
