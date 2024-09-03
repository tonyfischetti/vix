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


return M
