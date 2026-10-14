-- native insert-mode completion (replaces nvim-cmp)
--
-- one popup menu fed by the 'complete' option, in this order:
--   o   LSP (vim.lsp.completion, enabled per buffer on LspAttach; where no
--       server attaches, 'omnifunc' is whatever the ftplugin set, e.g.
--       syntaxcomplete for lisp)
--   .   words in this buffer
--   w,b words in other windows / listed buffers
--   F   paths     (M.paths below)
--   F   snippets  (M.snippets below -- luasnip's snipmate files)
--
-- keys (insert mode):
--   <Tab>    menu open: next item (a lone item is accepted outright)
--            in a snippet: jump to next placeholder
--            after a word: open the menu
--            otherwise: a tab
--   <S-Tab>  previous item / previous placeholder
--   <CR>     accept the selected item, or a newline if nothing is selected
--   <C-e>    abort (native)
--   <C-d>/<C-u>  scroll the documentation popup when the menu is open

local M = {}

local function line_before_cursor()
  local col = vim.api.nvim_win_get_cursor(0)[2]
  return vim.api.nvim_get_current_line():sub(1, col)
end

-- "n": no remapping; "i": put the keys *before* anything already in the
-- typeahead, so fast typing can't reorder them after the next character
local function keys(k)
  vim.api.nvim_feedkeys(vim.keycode(k), "ni", false)
end

----------------------------------------------------------------------
--  sources
----------------------------------------------------------------------

-- paths: kicks in once the text before the cursor contains a "/", and
-- completes the last component against the filesystem. directories get
-- a trailing "/" so another <Tab> descends into them.
--
-- the start column is the keyword boundary like every other source. a
-- function source *may* use its own start column, but the LSP source's
-- async reply restarts completion at the keyword boundary and the path
-- would then be inserted there (doubling the directory). so the
-- directory and the typed part of the component are read from the line,
-- and `word` is only what's left of the name after the non-keyword
-- part that is already typed (e.g. "lazy-lo|" -> word "lock.json")
function M.paths(findstart, base)
  local before = line_before_cursor()
  if findstart == 1 then
    return vim.fn.match(before, [[\k*$]])
  end

  local run = before:match("[%w%._%-~/$]+$") or ""
  local dir, prefix = run:match("^(.*/)([^/]*)$")
  if not dir then return {} end
  local strip = #prefix - #base
  if strip < 0 then return {} end
  local ok, entries = pcall(vim.fn.readdir, vim.fn.expand(dir))
  if not ok then return {} end

  local items = {}
  for _, name in ipairs(entries) do
    local hidden_ok = prefix:sub(1, 1) == "." or name:sub(1, 1) ~= "."
    if hidden_ok and vim.startswith(name, prefix) then
      local isdir = vim.fn.isdirectory(vim.fn.expand(dir) .. "/" .. name) == 1
      local suffix = isdir and "/" or ""
      items[#items + 1] = {
        word = name:sub(strip + 1) .. suffix,
        abbr = name .. suffix,
        menu = "[path]",
        dup = 0,
      }
    end
  end
  return items
end

-- snippets: every luasnip snippet for this filetype (plus the "all"
-- ones from _.snippets), by trigger. accepting one expands it (see the
-- CompleteDone autocmd in setup)
function M.snippets(findstart, base)
  if findstart == 1 then
    return vim.fn.match(line_before_cursor(), [[\k*$]])
  end
  local ls = require("luasnip")
  local items, seen = {}, {}
  for _, ft in ipairs({ vim.bo.filetype, "all" }) do
    for _, s in ipairs(ls.get_snippets(ft) or {}) do
      if not seen[s.trigger] then
        seen[s.trigger] = true
        local dscr = type(s.dscr) == "table" and table.concat(s.dscr, "\n") or s.dscr
        items[#items + 1] = {
          word = s.trigger,
          menu = "[snip]" .. ((s.name and s.name ~= s.trigger) and (" " .. s.name) or ""),
          info = (dscr and dscr ~= "") and dscr or nil,
          user_data = { vix_snippet = true },
          dup = 0,
        }
      end
    end
  end
  return items
end

----------------------------------------------------------------------
--  keys
----------------------------------------------------------------------

local function in_lsp_snippet(dir)
  return vim.snippet.active({ direction = dir })
end

function M.tab()
  local ls = require("luasnip")
  if vim.fn.pumvisible() == 1 then
    local info = vim.fn.complete_info({ "items", "selected" })
    if #info.items == 1 then
      keys(info.selected == -1 and "<C-n><C-y>" or "<C-y>")
    else
      keys("<C-n>")
    end
  elseif ls.jumpable(1) then
    ls.jump(1)
  elseif in_lsp_snippet(1) then
    vim.snippet.jump(1)
  elseif line_before_cursor():match("%S$") then
    keys("<C-n>")
  else
    keys("<Tab>")
  end
end

function M.shift_tab()
  local ls = require("luasnip")
  if vim.fn.pumvisible() == 1 then
    keys("<C-p>")
  elseif ls.jumpable(-1) then
    ls.jump(-1)
  elseif in_lsp_snippet(-1) then
    vim.snippet.jump(-1)
  else
    keys("<S-Tab>")
  end
end

-- <CR>: accept only an explicitly selected item (like cmp's select=false)
function M.cr()
  if vim.fn.pumvisible() == 1 then
    if vim.fn.complete_info({ "selected" }).selected ~= -1 then
      return "<C-y>"
    end
    return "<C-e><CR>"
  end
  return "<CR>"
end

local function scroll_docs(lines)
  return function()
    if vim.fn.pumvisible() == 1 then
      local win = vim.fn.complete_info({ "preview_winid" }).preview_winid
      if win and win ~= 0 and vim.api.nvim_win_is_valid(win) then
        vim.api.nvim_win_call(win, function()
          vim.cmd("normal! " .. (lines > 0 and (lines .. "\x05") or (-lines .. "\x19"))) -- <C-e> / <C-y> scroll
        end)
        return
      end
    end
    keys(lines > 0 and "<C-d>" or "<C-u>")
  end
end

----------------------------------------------------------------------
--  setup
----------------------------------------------------------------------

function M.setup()
  require("luasnip.loaders.from_snipmate").lazy_load()

  vim.opt.completeopt = { "menu", "menuone", "noselect", "fuzzy", "popup" }
  vim.opt.pumborder = "rounded"
  vim.opt.complete = {
    "o",
    ".", "w", "b",
    "Fv:lua.require'vix.lib.completion'.paths",
    "Fv:lua.require'vix.lib.completion'.snippets",
  }

  -- LSP completion per attached client (manual trigger, no autotrigger)
  vim.api.nvim_create_autocmd("LspAttach", {
    group = vim.api.nvim_create_augroup("vix_completion_lsp", { clear = true }),
    callback = function(args)
      vim.lsp.completion.enable(true, args.data.client_id, args.buf, { autotrigger = false })
    end,
  })

  -- expand a snippet picked from the menu
  vim.api.nvim_create_autocmd("CompleteDone", {
    group = vim.api.nvim_create_augroup("vix_completion_snippets", { clear = true }),
    callback = function()
      local item = vim.v.completed_item
      if type(item) == "table" and type(item.user_data) == "table" and item.user_data.vix_snippet then
        local ls = require("luasnip")
        if ls.expandable() then ls.expand() end
      end
    end,
  })

  local map = vim.keymap.set
  map({ "i", "s" }, "<Tab>",   M.tab)
  map({ "i", "s" }, "<S-Tab>", M.shift_tab)
  map("i", "<CR>",  M.cr, { expr = true })
  map("i", "<C-d>", scroll_docs(4))
  map("i", "<C-u>", scroll_docs(-4))
end

return M
