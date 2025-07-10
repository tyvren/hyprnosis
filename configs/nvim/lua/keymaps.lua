vim.keymap.set("n", "<F5>", require("config.runner").run_file, {
  noremap = true,
  desc = "Run full script in terminal"
})

vim.keymap.set("v", "<F6>", require("config.runner").send_selection, {
  noremap = true,
  desc = "Send selected lines to terminal"
})

vim.keymap.set("n", "<F7>", require("config.runner").stop_runner, {
  noremap = true,
  desc = "Stop the running script"
})
