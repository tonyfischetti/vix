local utils = require('../vix/lib/utils')
local shell = require('../vix/lib/shell')


local M = {}

function M.get_pane_number(list_panes_output_line)
  return string.sub(list_panes_output_line,
                    list_panes_output_line:find("%%")+1,
                    #list_panes_output_line)
end

function M.get_other_tmux_pane()
  local other_panes = shell.shell_output_lines("tmux list-panes | grep -v '.active.$'")
  if #other_panes ~= 1 then
    return nil
  end
  --  HACK:
  return "%" .. M.get_pane_number(other_panes[1])
end

function M.get_active_tmux_pane()
  local all_panes = utils.map(shell.shell_output_lines("tmux list-panes"), M.get_pane_number)
  for i=1, #all_panes do
    local tmp = all_panes[i]:find(" .active.")
    if tmp ~= nil then
      return string.sub(all_panes[i], 1, tmp-1)
    end
  end
  return nil
end

-- always returns active pane first
function M.get_all_tmux_panes()
  local active_pane = ""
  local rest = {}
  local all_panes = utils.map(shell.shell_output_lines("tmux list-panes"), M.get_pane_number)
  for i=1, #all_panes do
    local tmp = all_panes[i]:find(" .active.")
    if tmp ~= nil then
      active_pane = string.sub(all_panes[i], 1, tmp-1)
    else
      table.insert(rest, all_panes[i])
    end
  end
  return utils.cons(active_pane, rest)
end

-- returns pane number of new pane
function M.create_pane(horizontal_p)
  local cmd1 = "tmux split-window"
  local cmd2 = "tmux select-pane"
  if horizontal_p then
    cmd1 = cmd1 .. " -h"
    cmd2 = cmd2 .. " -L"
  else
    cmd1 = cmd1 .. " -v"
    cmd2 = cmd2 .. " -U"
  end
  vim.fn.system(cmd1)
  local new_pane = M.get_active_tmux_pane()
  vim.fn.system(cmd2)
  return new_pane
end


  -- return utils.join_array(utils.map(all_panes, M.get_pane_number), ", ")

return M
