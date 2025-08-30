return {
  {
    "catppuccin/nvim",
    name = "catppuccin",
    priority = 1000,
    config = function()
      -- Pick your flavor here
      vim.cmd.colorscheme("catppuccin-mocha")
    end,
  },
}
