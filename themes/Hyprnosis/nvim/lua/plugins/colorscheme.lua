return {
	-- add colorscheme
	{ "folke/tokyonight.nvim" },

	-- Configure LazyVim to load colorscheme
	{
		"LazyVim/LazyVim",
		opts = {
			colorscheme = "tokyonight",
		},
	},
}
