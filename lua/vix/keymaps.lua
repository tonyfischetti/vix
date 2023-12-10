
local fns = require('vix.lib.functions')
local map = vim.keymap.set


map("i", "<CR>", [[pumvisible() ? "<C-y>" : "<CR>"]], { expr = true })

-- shortcuts for pluto special characters
map("i", "<C-O><C-O>", "•")
map("i", "<C-O><C-B>", "«")
map("i", "<C-O><C-N>", "»")

--hop things
map("n", "S", ":HopWord<CR>")

--Set visual mode indent
map("v", "<", "<gv")
map("v", ">", ">gv")

--tComment
map("v", "?", ":TComment<CR>")

--no Ex mode
map("n", "Q", "<nop>")

--Easier Redo (u/U = Undo/Redo)
map("n","U", "<C-R>")

--gotta do it the vim way
map({"n", "i"}, "<Left>",  "<nop>")
map({"n", "i"}, "<Right>", "<nop>")
map({"n", "i"}, "<Up>",    "<nop>")
map({"n", "i"}, "<Down>",  "<nop>")

-- snipmate
map("i", "<C-J>", "<Plug>snipMateNextOrTrigger")

-- Small motion plugin
map("n", "s", "<Plug>(smalls)")

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
map("n","<Leader>nh", ":noh<CR>", { silent = true })
map("n","<C-c>", ":noh<CR>", { silent = true })

-- toggle ColorColumn
map('n', '<Leader>cc', fns.toggle_opt('colorcolumn', 'wo', '79', '0'))

-- another hop thing
map("n", "<Leader>er", ":HopWord<CR>")

--Find and replace (with 'magic')
map("n", "<Leader>fr", ":%s/\\v")

-- -- toggle just the color column
-- map("n", "<Leader>cc", ":call ColorColumn()<CR>", { silent = true })

-- " insert date right into document
--     old way
map("n", "<Leader>do", ":r! date<CR>", { silent = true })
--     new way
map("n", "<Leader>dd", "o<Esc>18i#<Esc>3a<Space><Esc>o<Esc>:.!date<CR>kJ3A<Space><Esc>18a#<Esc><CR>")



-- auto-reform ugly json
map("n", "<Leader>rj", ":%!python3 -mjson.tool<CR>")

-- highlight trailing whitespace
map("n", "<Leader>tw", ":/\\v\\s+$/<CR>", { silent = true })

-- remove trailing whitespace
map("n", "<Leader>rw", ":%s/\\v\\s+$//<CR>", { silent = true })

-- easy map to turn back on rainbow parens after color scheme change
map("n", "<Leader>rp", ":call niji#highlight()<CR>", { silent = true })

-- easy map to alternate favorite color schemes
map("n", "<Leader>lc", ":color lcars<CR>", { silent = true })
map("n", "<Leader>lb", ":color lcars-black<CR>", { silent = true })
map("n", "<Leader>mo", ":color molokai<CR>", { silent = true })
map("n", "<Leader>fl", ":color flattr<CR>", { silent = true })
map("n", "<Leader>dr", ":color dracula<CR>", { silent = true })
map("n", "<Leader>tf", ":color terafox<CR>", { silent = true })
map("n", "<Leader>ma", ":color material<CR>", { silent = true })
map("n", "<Leader>go", ":color gotham256<CR>", { silent = true })
map("n", "<Leader>tn", ":color tokyonight-night<CR>", { silent = true })
map("n", "<Leader>ei", ":color Tomorrow-Night-Eighties<CR>", { silent = true })

map("n", "<Leader>vt", ":vsplit | terminal <CR> i")
map("n", "<Leader>ht", ":split | terminal  <CR> i")

map("n", "<Leader>tt", ":FloatermToggle<CR>")
map("n", "<Leader>mm", ":FloatermNew --cwd=<root><CR>")
