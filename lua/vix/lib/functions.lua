local M = {}

M.proj_proj_root = ""

function M.get_proj_proj_root()
  return M.proj_proj_root
end

function M.set_proj_proj_root(aroot)
  M.proj_proj_root = aroot
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
