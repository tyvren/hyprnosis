local M = {}

local Terminal = require("toggleterm.terminal").Terminal
local runner_term = nil
local send_term = nil

-- 🔁 Run the full current file
function M.run_file()
  vim.cmd("w")
  local file = vim.fn.expand("%:p")
  local ext = vim.fn.expand("%:e")
  local cmd = ""

  -- 🥇 PowerShell prioritized
  if ext == "ps1" then
    -- Use full path to pwsh
    cmd = "/usr/local/bin/pwsh -NoLogo -File \"" .. file .. "\""
  elseif ext == "py" then
    cmd = "python \"" .. file .. "\""
  elseif ext == "lua" then
    cmd = "lua \"" .. file .. "\""
  elseif ext == "js" then
    cmd = "node \"" .. file .. "\""
  elseif ext == "sh" then
    cmd = "bash \"" .. file .. "\""
  elseif ext == "rb" then
    cmd = "ruby \"" .. file .. "\""
  elseif ext == "ts" then
    cmd = "ts-node \"" .. file .. "\""
  elseif ext == "go" then
    cmd = "go run \"" .. file .. "\""
  else
    vim.notify("Unsupported file type: ." .. ext, vim.log.levels.WARN)
    return
  end

  -- 🔄 Shutdown existing terminal
  if runner_term then
    runner_term:shutdown()
  end

  -- ▶️ Create new terminal
  runner_term = Terminal:new({
    cmd = cmd,
    direction = "horizontal",
    close_on_exit = false,
    start_in_insert = true,
    on_exit = function(_, code)
      if code ~= 0 then
        vim.schedule(function()
          vim.notify("Script exited with error code " .. code, vim.log.levels.ERROR)
        end)
      end
    end,
  })

  runner_term:toggle()
end

-- 🔁 Send visual selection to shell terminal
function M.send_selection()
  local start_line = vim.fn.line("v")
  local end_line = vim.fn.line(".")
  if start_line > end_line then
    start_line, end_line = end_line, start_line
  end

  local lines = vim.api.nvim_buf_get_lines(0, start_line - 1, end_line, false)

  -- 🧠 Map file extensions to preferred shells or full commands
  local shell_map = {
    ps1 = "/usr/local/bin/pwsh", -- PowerShell Core full path
    sh  = "bash",  -- Bash scripts
    zsh = "zsh",   -- Zsh scripts
    py  = "python",-- Optional, for REPL usage
  }

  -- 🔍 Detect extension and look up shell/command
  local ext = vim.fn.expand("%:e")
  local shell_or_cmd = shell_map[ext] or vim.o.shell

  vim.notify("Using shell/command: " .. shell_or_cmd)  -- 👈 Debug confirmation

  -- 🛠 Create or open terminal with correct cmd for pwsh, else shell
  if not send_term then
    send_term = Terminal:new({
      direction = "horizontal",
      hidden = true,
      start_in_insert = true,
      cmd = (ext == "ps1") and shell_or_cmd or nil,  -- Use cmd for pwsh to launch pwsh explicitly
      shell = (ext ~= "ps1") and shell_or_cmd or nil, -- Use shell for others
    })
    send_term:open()
  elseif not send_term:is_open() then
    send_term:open()
  end

  -- 📨 Send selected lines to terminal
  for _, line in ipairs(lines) do
    send_term:send(line .. "\n", false)
  end
end

-- ⛔ Stop the current script/terminal
function M.stop_runner()
  if runner_term and runner_term:is_open() then
    runner_term:shutdown()
    vim.notify("Runner terminal stopped", vim.log.levels.INFO)
  else
    vim.notify("No script is currently running", vim.log.levels.WARN)
  end
end

return M

