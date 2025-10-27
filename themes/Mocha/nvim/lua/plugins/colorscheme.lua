return {
	-- add colorscheme
	{ "catppuccin/nvim" },

	-- Configure LazyVim to load colorscheme
	{
		"LazyVim/LazyVim",
		opts = {
			colorscheme = "catppuccin",
		},
	},
}
