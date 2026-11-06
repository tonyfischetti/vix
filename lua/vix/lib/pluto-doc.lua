-- K in lisp buffers: a symbol's signature and docstring, asked of the
-- saved core by ~/.zsh/bin/pluto-doc, in a floating window the way
-- LSP hover does it (rounded border from 'winborder', closes when
-- the cursor moves, K again focuses it so it can be scrolled, q
-- closes it from inside)
--
-- highlighting is done here, with extmarks over pluto-doc's output:
-- there's no lisp treesitter parser in this config (nvim-treesitter
-- was removed on purpose -- see plugins/tree-sitter.lua), and vim's
-- regex lisp syntax would run amok over the docstring prose (one
-- stray `"` paints everything after it as a string)

local M = {}

local ns = vim.api.nvim_create_namespace('pluto-doc')

-- characters that make up a lisp symbol, for word boundaries
local SYM = '[%w%-_!*/?<>=+.]'

local function mark(buf, row, s, e, group)
  vim.api.nvim_buf_set_extmark(buf, ns, row, s - 1, {
    end_col  = e,
    hl_group = group,
    -- strings and characters win over the parens found inside them
    priority = (group == 'String' or group == 'Character') and 4200 or 4100,
  })
end

-- every match of PAT on LINE -> mark it (the whole match)
local function mark_all(buf, row, line, pat, group, accept)
  local init = 1
  while true do
    local s, e = line:find(pat, init)
    if not s then break end
    if not accept or accept(s, e) then mark(buf, row, s, e, group) end
    init = e + 1
  end
end

-- the header: `pkg:name  kind`
local function hl_header(buf, row, line)
  local s, e = line:find('^%S+')
  if s then mark(buf, row, s, e, 'Title') end
  local ks = line:find('%s%s+%S+$')
  if ks then mark(buf, row, ks + 2, #line, 'Comment') end
end

-- the signature (one or more lines): a lisp form
local function hl_signature(buf, row, line, first_p)
  if first_p then
    local s, e = line:find('^%(' .. SYM .. '+')
    if s then mark(buf, row, s + 1, e, 'Function') end
  end
  mark_all(buf, row, line, '"[^"]*"', 'String')
  -- (#\Space, #\Tab, #\0 -- stop before a closing paren)
  mark_all(buf, row, line, '#\\%S[^%s()]*', 'Character')
  mark_all(buf, row, line, '&%a[%a%-]*', 'Keyword')
  mark_all(buf, row, line, ':' .. SYM .. '+', 'Constant', function(s)
    local prev = s > 1 and line:sub(s - 1, s - 1) or ' '
    return prev == ' ' or prev == '('
  end)
  mark_all(buf, row, line, '%f[' .. SYM:sub(2, -2) .. ']nil%f[^' .. SYM:sub(2, -2) .. ']', 'Boolean')
  mark_all(buf, row, line, '%f[' .. SYM:sub(2, -2) .. ']t%f[^' .. SYM:sub(2, -2) .. ']', 'Boolean')
  mark_all(buf, row, line, '[()]', 'Delimiter')
end

-- the docstring: `backticked` code and UPPERCASE parameter references
local function hl_prose(buf, row, line)
  mark_all(buf, row, line, '`[^`]+`', 'Special')
  mark_all(buf, row, line, '%f[%w*][%u][%u%d%-!*]+%f[^%w%-!*]', 'Identifier')
end

-- the "names and docstrings mentioning it" listing (exit status 1)
local function hl_listing(buf, row, line)
  if row == 0 then
    mark(buf, row, 1, #line, 'WarningMsg')
    return
  end
  local s, e = line:find('^%s+%S+')
  if s then mark(buf, row, s, e, 'Title') end
  local ks, ke = line:find('%s+%a+%s', (e or 0) + 1)
  if ks then mark(buf, row, ks, ke, 'Comment') end
  if ke then hl_signature(buf, row, line, false) end
end

local function highlight(buf, found_p)
  local lines = vim.api.nvim_buf_get_lines(buf, 0, -1, false)
  local in_prose = false
  for i, line in ipairs(lines) do
    local row = i - 1
    if line:match('^note: ') then
      mark(buf, row, 1, #line, 'WarningMsg')
    elseif not found_p then
      hl_listing(buf, row, line)
    elseif row == 0 then
      hl_header(buf, row, line)
    elseif in_prose then
      hl_prose(buf, row, line)
    elseif line == '' then
      in_prose = true
    elseif line == '(no docstring)' then
      mark(buf, row, 1, #line, 'Comment')
    elseif line:match('^%(') or line:match('^%s') then
      hl_signature(buf, row, line, line:match('^%(') ~= nil)
    else
      -- `value: ...` for variables, `(no docstring)`, the anaphor note
      mark(buf, row, 1, #line, 'Comment')
    end
  end
end

function M.show(word)
  if word == nil or word == '' then return end
  vim.system({ 'pluto-doc', word }, { text = true }, vim.schedule_wrap(function(r)
    if (r.stdout or '') == '' then
      vim.notify(vim.trim((r.stderr ~= '' and r.stderr) or ('pluto-doc ' .. word .. ': no output')),
                 vim.log.levels.WARN)
      return
    end
    local lines = vim.split(vim.trim(r.stdout), '\n', { plain = true })
    if r.stderr and vim.trim(r.stderr) ~= '' then
      -- the stale-core note, mostly
      vim.list_extend(lines, { '', vim.trim(r.stderr) })
    end
    local buf = vim.lsp.util.open_floating_preview(lines, '', {
      focus_id  = 'pluto-doc',
      focus     = true,
      wrap      = true,
      max_width = 80,
    })
    vim.api.nvim_buf_clear_namespace(buf, ns, 0, -1)
    highlight(buf, r.code == 0)
  end))
end

return M
