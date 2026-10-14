local shell  = require('../vix/lib/shell')
local tmuxer = require('../vix/lib/tmuxer')

local M = {}


function M.new_slime(starting_command, horizontal_p)
  local new_pane = tmuxer.create_pane(horizontal_p)
  vim.b.slime_config = {
    socket_name = "default",
    target_pane = '%' .. new_pane
  }
  vim.g.slime_target = "tmux"
  vim.g.slime_no_mappings = 1
  vim.g.slime_dont_ask_default = 1
  vim.notify("slime setup on pane " .. new_pane)
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


----------------------------------------------------------------------
--  RStudio-style "run statement" for R
--
--  the lines that make up the expression around the cursor: a
--  multi-line call, a function / if / for block, a pipeline. on a
--  plain line it is just that line, so this replaces send_line in R
--  buffers. no parser: brackets are counted (ignoring strings and
--  comments) and lines ending in an operator or comma continue.
----------------------------------------------------------------------

-- the line with each string literal replaced by `S` and the trailing
-- comment removed, so brackets and operators inside them don't count
local function r_code_only(line)
  local out, i, n = {}, 1, #line
  while i <= n do
    local c = line:sub(i, i)
    if c == "#" then break end
    if c == '"' or c == "'" or c == "`" then
      i = i + 1
      while i <= n do
        local d = line:sub(i, i)
        if d == "\\" then i = i + 2
        elseif d == c then break
        else i = i + 1 end
      end
      i = i + 1
      out[#out + 1] = "S"
    else
      out[#out + 1] = c
      i = i + 1
    end
  end
  return table.concat(out)
end

-- bracket depth over the line: net change, and the lowest point reached
-- (negative when the line closes something opened on an earlier line)
local function r_depth(code)
  local d, low = 0, 0
  for ch in code:gmatch("[%(%[{%)%]}]") do
    d = d + ((ch == "(" or ch == "[" or ch == "{") and 1 or -1)
    if d < low then low = d end
  end
  return d, low
end

-- does the line end mid-expression? (operator, comma, pipe, `else`)
local function r_continues(code)
  code = code:gsub("%s+$", "")
  return code:match("[%+%-%*/%^~=<>&|,%%]$") ~= nil or code:match("%f[%w]else$") ~= nil
end

-- does the line end by opening a call or index? (`(` or `[`, not `{`:
-- the statements inside a `{` block are independent of its header)
local function r_opens_call(code)
  code = code:gsub("%s+$", "")
  return code:match("[%(%[]$") ~= nil
end

local function r_starts_with_else(code)
  return code:match("^%s*else%f[%W]") ~= nil
end

-- first and last line of the statement around the cursor
function M.r_statement_range()
  local last = vim.api.nvim_buf_line_count(0)
  local cache = {}
  local function code(l)
    if not cache[l] then cache[l] = r_code_only(vim.fn.getline(l)) end
    return cache[l]
  end

  local s = vim.fn.line(".")
  local e = s
  if not code(s):match("%S") then return s, e end
  local depth, low = r_depth(code(s))

  -- grow in both directions until stable. `depth - low` is how many
  -- brackets opened inside the block are still open at its end; `low < 0`
  -- means the block closes something that was opened above it
  local changed = true
  while changed do
    changed = false
    while s > 1 and (low < 0 or r_continues(code(s - 1)) or r_opens_call(code(s - 1))) do
      s = s - 1
      local n, m = r_depth(code(s))
      low = math.min(m, n + low)
      depth = depth + n
      changed = true
    end
    while e < last and (depth - low > 0 or r_continues(code(e)) or r_starts_with_else(code(e + 1))) do
      e = e + 1
      local n, m = r_depth(code(e))
      low = math.min(low, depth + m)
      depth = depth + n
      changed = true
    end
  end
  return s, e
end

-- big statements are not pasted: R's line editor drops input when a
-- long paste arrives faster than it can echo it (slime sends 1000-char
-- chunks back to back). instead the statement goes to a temp file and R
-- gets one short `source(..., echo = TRUE)` line, so it reads the code
-- itself and still shows it. small statements are pasted as before so
-- they stay recallable from the console history
M.source_threshold = 800  -- bytes

local function r_send(text)
  if #text > M.source_threshold then
    local path = vim.fn.tempname() .. ".R"   -- under nvim's per-session tmp dir, removed on exit
    vim.fn.writefile(vim.split(text, "\n"), path)
    vim.fn["slime#send"](string.format('source("%s", echo = TRUE, max.deparse.length = Inf)\n', path))
  else
    vim.fn["slime#send"](text .. "\n")
  end
end

-- send the statement and step past it
function M.send_statement()
  local s, e = M.r_statement_range()
  local text = table.concat(vim.api.nvim_buf_get_lines(0, s - 1, e, false), "\n")
  if text:match("%S") then
    r_send(text)
  end
  vim.fn.cursor(e + 1, 0)
end


return M
