return {
  "akinsho/toggleterm.nvim",
  version = "*",
  config = function()
    require("toggleterm").setup({
      size = 15,
      open_mapping = [[<c-\>]],
      direction = "horizontal",
      start_in_insert = true,
      shade_terminals = true,
      close_on_exit = true,
    })
  end,
}

