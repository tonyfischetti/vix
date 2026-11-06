-- an nvim-cmp source for pluto (and charon, and styx): every exported
-- symbol, with its signature, straight from the saved core by way of
-- `pluto-doc -l` (~/.zsh/bin). lisp buffers only -- see completion.lua
--
-- the listing is loaded once and cached; it reloads when the core is
-- rebuilt (its mtime changes). the full docstring is fetched lazily,
-- when an entry is highlighted (`pluto-doc NAME`)

local M = {}

local CORE = vim.fn.expand('~/.lisp/pluto-sbcl.core')

local cache = {
  core_mtime = nil,      -- mtime of the core the items came from
  plain      = nil,      -- items labelled `name`
  qualified  = nil,      -- items labelled `pkg:name`
  docs       = {},       -- name -> resolved documentation
  loading    = nil,      -- callbacks waiting on a load in progress
}

local KINDS = {
  ['function'] = 'Function',
  ['macro']    = 'Keyword',
  ['variable'] = 'Variable',
  ['symbol']   = 'Text',   -- an anaphor (index!, value!...)
}


local function core_mtime()
  local st = (vim.uv or vim.loop).fs_stat(CORE)
  return st and st.mtime.sec or nil
end

-- one TSV line (name, kind, package, signature, first doc line) -> two
-- completion items: the bare name and the package-qualified one
local function parse(line)
  local f = vim.split(line, '\t', { plain = true })
  if #f < 5 then return nil end
  local name, kind, pkg, signature, doc = f[1], f[2], f[3], f[4], f[5]
  local function item(label)
    return {
      label         = label,
      kind          = require('cmp').lsp.CompletionItemKind[KINDS[kind] or 'Text'],
      detail        = signature,
      labelDetails  = { description = pkg },
      documentation = {
        kind  = 'plaintext',
        value = signature .. (doc ~= '' and ('\n\n' .. doc) or ''),
      },
      data = { name = name, pkg = pkg },
    }
  end
  return item(name), item(pkg .. ':' .. name)
end

local function load(on_done)
  if cache.loading then
    table.insert(cache.loading, on_done)
    return
  end
  cache.loading = { on_done }
  local mtime = core_mtime()
  vim.system({ 'pluto-doc', '-l' }, { text = true }, vim.schedule_wrap(function(result)
    local plain, qualified = {}, {}
    if result.code == 0 then
      for _, line in ipairs(vim.split(result.stdout or '', '\n', { trimempty = true })) do
        local p, q = parse(line)
        if p then
          table.insert(plain, p)
          table.insert(qualified, q)
        end
      end
    else
      vim.notify('pluto-doc -l failed: ' .. (result.stderr or ''), vim.log.levels.ERROR)
    end
    -- the stale-core note, mostly
    if result.stderr and result.stderr ~= '' and result.code == 0 then
      vim.notify(vim.trim(result.stderr), vim.log.levels.WARN)
    end
    cache.plain, cache.qualified, cache.core_mtime, cache.docs = plain, qualified, mtime, {}
    local waiting = cache.loading
    cache.loading = nil
    for _, cb in ipairs(waiting) do cb() end
  end))
end

local function with_items(fn)
  if cache.plain and cache.core_mtime == core_mtime() then
    fn()
  else
    load(fn)
  end
end


-----------------------------------
--        the cmp source         --
-----------------------------------

local source = {}

function source.new()
  return setmetatable({}, { __index = source })
end

function source:get_debug_name()
  return 'pluto'
end

function source:is_available()
  return vim.bo.filetype == 'lisp'
end

-- lisp symbols are made of 'iskeyword' characters (*pluto-shell*,
-- md5/file, index!, styx:tty-p), which cmp's default pattern would
-- cut short
function source:get_keyword_pattern()
  return [[\k\+]]
end

function source:complete(params, callback)
  with_items(function()
    -- typed a package prefix (styx:md5/)? then offer qualified names
    local word = params.context.cursor_before_line:match('[^%s()]*$') or ''
    callback({ items = word:find(':', 1, true) and cache.qualified or cache.plain,
               isIncomplete = false })
  end)
end

-- the full docstring, on demand
function source:resolve(item, callback)
  local name = item.data and item.data.name
  if not name then return callback(item) end
  if cache.docs[name] then
    item.documentation = { kind = 'plaintext', value = cache.docs[name] }
    return callback(item)
  end
  vim.system({ 'pluto-doc', item.data.pkg .. ':' .. name }, { text = true },
    vim.schedule_wrap(function(result)
      if result.code == 0 and result.stdout and result.stdout ~= '' then
        cache.docs[name] = vim.trim(result.stdout)
        item.documentation = { kind = 'plaintext', value = cache.docs[name] }
      end
      callback(item)
    end))
end

M.new = source.new

return M
