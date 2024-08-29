local M = {}

--  HACK:
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


return M
