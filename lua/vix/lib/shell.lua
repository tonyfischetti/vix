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

function M.run_buffer_through_cmd(whole_buffer_p, cmd)
    if whole_buffer_p then
      vim.cmd(string.format("%%! %s", cmd))
    else
      vim.cmd(string.format("'<,'>! %s", cmd))
    end
end

function M.search_and_replace(whole_buffer_p)
  vim.ui.input({ prompt= "perl regex" },
    function(input)
      if input ~= nil and input ~= "" then
        M.run_buffer_through_cmd(whole_buffer_p,
                                string.format("perl -ple '%s'", input))
      end
    end)
end

function M.run_command(whole_buffer_p)
  vim.ui.input({ prompt= "external command" },
    function(input)
      if input ~= nil and input ~= "" then
        M.run_buffer_through_cmd(whole_buffer_p, input)
      end
    end)
end




return M
