local M = {}

--  HACK 
M.proj_proj_root = nil

function M.get_proj_proj_root()
  return M.proj_proj_root
end

function M.set_proj_proj_root(aroot)
  M.proj_proj_root = aroot
end

-- maps `pwd` to git root (or nothing)
M.git_root_cache = {}

function M.get_git_root()
  local pwd = vim.fn.getcwd()
  local in_cache = M.git_root_cache[pwd]
  if in_cache then
    return in_cache
  else
    local dot_git_path = vim.fn.finddir(".git", ".;")
    if dot_git_path ~= "" then
      M.git_root_cache[pwd] = vim.fn.fnamemodify(dot_git_path, ":h")
    end
  end
  return M.git_root_cache[pwd]
end


function M.get_find_files_root()
  local proj_proj_root_p = M.get_proj_proj_root()
  if proj_proj_root_p then
    return proj_proj_root_p
  end
  local git_root_p = M.get_git_root()
  if git_root_p then
    return git_root_p
  end
  return vim.fn.getcwd()
end


function M.array_init(dirs)
  local len = #dirs
  if len == 1 then
    return { "" }
  end
  table.remove(dirs, len)
  return dirs
end

function M.toggle_opt(prop, scope, on, off)
  if on == nil then
    on = true
  end

  if off == nil then
    off = false
  end

  if scope == nil then
    scope = 'o'
  end

  return function()
    if vim[scope][prop] == on then
      vim[scope][prop] = off
    else
      vim[scope][prop] = on
    end
  end
end


function M.join_array(an_array, sep)
  local ret = an_array[1]
  for i=2, #an_array do
    ret = ret .. sep .. an_array[i]
  end
  return ret
end

function M.map(an_array, fn)
  local ret = {}
  for i=1, #an_array do
    table.insert(ret, fn(an_array[i]))
  end
  return ret
end

function M.cons(an_elem, an_array)
  local ret = {}
  table.insert(ret, an_elem)
  for _,v in ipairs(an_array) do
    table.insert(ret, v)
  end
  return ret
end



function M.insert_lines_into_buffer(lines)
  local line_number    = vim.api.nvim_win_get_cursor(0)[1]
  local position       = vim.api.nvim_win_get_cursor(0)[2]
  local current_line   = vim.api.nvim_get_current_line()
  vim.api.nvim_buf_set_lines(0, line_number-1, line_number-1, true, lines)
end

return M
