local M = {}


function M.shell_output_lines(command)
  local output_lines = {}
  local resp = vim.fn.system(command)
  local i = 0
  local lag = i
  while true do
    i = resp:find("\n", i+1)
    if i == nil then break end
    table.insert(output_lines, string.sub(resp, lag, i-1))
    lag = i+1
  end
  return output_lines
end


return M
