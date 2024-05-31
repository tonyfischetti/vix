
local fns = require('vix.lib.functions')
local map = vim.keymap.set


map("i", "<CR>", [[pumvisible() ? "<C-y>" : "<CR>"]], { expr = true })

-- shortcuts for pluto special characters
map("i", "<C-O><C-O>", "•")
map("i", "<C-O><C-B>", "«")
map("i", "<C-O><C-N>", "»")

--Set visual mode indent
map("v", "<", "<gv")
map("v", ">", ">gv")

--tComment
map("v", "?", ":TComment<CR>")

--no Ex mode
map("n", "Q", "<nop>")

-- Small motion plugin
map("n", "s", "<Plug>(smalls)")

--hop things
map("n", "S", ":HopWord<CR>")

--Easier Redo (u/U = Undo/Redo)
map("n","U", "<C-R>")

--gotta do it the vim way
map({"n", "i"}, "<Left>",  "<nop>")
map({"n", "i"}, "<Right>", "<nop>")
map({"n", "i"}, "<Up>",    "<nop>")
map({"n", "i"}, "<Down>",  "<nop>")

-- snipmate
map("i", "<C-J>", "<Plug>snipMateNextOrTrigger")

-- This makes the current match more visible
-- and also centers the match vertically in the buffer
map("n", "n", "n:call HLNext()<CR>zz", { silent = true })
map("n", "N", "N:call HLNext()<CR>zz", { silent = true })

map("t", "<Esc>", "<C-\\><C-n>")
map("t", "<C-v><Esc>", "<Esc>")

map("n", "<C-S>", "<C-W>")

-- x should not copy a single character into the clipboard
map("n", "x", [["_x]])

map({"t", ""}, "<M-k>", "<C-\\><C-n><C-w>k")
map({"t", ""}, "<M-j>", "<C-\\><C-n><C-w>j")

-----------------------------------------------------
---- LEADER MAPS ------------------------------------

--Turn off highlights from search
map("n","<Leader>H", ":noh<CR>", { silent = true })
map("n","<C-c>", ":noh<CR>", { silent = true })

-- toggle ColorColumn
map('n', '<Leader>C', fns.toggle_opt('colorcolumn', 'wo', '79', '0'))

--Find and replace (with 'magic')
map("n", "<Leader>r", ":%s/\\v")

-- " insert date right into document
-- --     old way
-- map("n", "<Leader>do", ":r! date<CR>", { silent = true })
--     new way
map("n", "<Leader>d", "o<Esc>18i#<Esc>3a<Space><Esc>o<Esc>:.!date<CR>kJ3A<Space><Esc>18a#<Esc><CR>")


-- auto-reform ugly json
map("n", "<Leader>j", ":%!python3 -mjson.tool<CR>")

-- remove trailing whitespace
map("n", "<Leader>W", ":%s/\\v\\s+$//<CR>", { silent = true })

-- easy map to turn back on rainbow parens after color scheme change
map("n", "<Leader>P", ":call niji#highlight()<CR>", { silent = true })

map("n", "<Leader>vt", ":vsplit | terminal <CR> i")
map("n", "<Leader>ht", ":split | terminal  <CR> i")

map("n", "<Leader>m", ":FloatermToggle<CR>")
map("n", "<Leader>M", ":FloatermNew --cwd=<root><CR>")
map("n", "<Leader>e", ":NvimTreeToggle<CR>")

map("n", "<Leader>.", ":BufferLineCycleNext<CR>", { silent = true })
map("n", "<Leader>,", ":BufferLineCyclePrev<CR>", { silent = true })

