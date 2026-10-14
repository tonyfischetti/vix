local shell  = require('../vix/lib/shell')
local tmuxer = require('../vix/lib/tmuxer')

local M = {}


function M.new_slime(starting_command, horizontal_p)
  local notify = require('notify')
  local new_pane = tmuxer.create_pane(horizontal_p)
  vim.b.slime_config = {
    socket_name = "default",
    target_pane = '%' .. new_pane
  }
  vim.g.slime_target = "tmux"
  vim.g.slime_no_mappings = 1
  vim.g.slime_dont_ask_default = 1
  notify("slime setup on pane " .. new_pane)
  if starting_command ~= nil and starting_command ~= "" then
    vim.cmd(string.format("SlimeSend1 %s", starting_command))
  end
end


-- send the current line (if non-empty) and step to the next line.
-- unlike slime's own line-send, this never skips over empty lines
function M.send_line()
  local next_line = vim.fn.line('.') + 1
  if #vim.fn.getline('.') > 0 then
    vim.fn['slime#send_lines'](1)
  end
  vim.fn.cursor(next_line, 0)
end

-- same, but leave the cursor where it is (used from insert mode)
function M.send_line_same_place()
  if #vim.fn.getline('.') > 0 then
    vim.fn['slime#send_lines'](1)
  end
end


return M
