return {
  -- add Dracula colorscheme
  { "Mofiqul/dracula.nvim" },

  -- Configure LazyVim to load colorscheme
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "dracula",
    },
  },
}
