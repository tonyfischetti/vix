
local fns = require('../vix/lib/functions')
local map = vim.keymap.set

-- shortcuts for pluto special characters
map("i", "<C-O><C-O>", "•")
map("i", "<C-O><C-B>", "«")
map("i", "<C-O><C-N>", "»")

--Set visual mode indent
map("v", "<", "<gv")
map("v", ">", ">gv")

--no Ex mode
map("n", "Q", "<nop>")

--Easier Redo (u/U = Undo/Redo)
map("n","U", "<C-R>")

--gotta do it the vim way
map({"n", "i"}, "<Left>",  "<nop>")
map({"n", "i"}, "<Right>", "<nop>")
map({"n", "i"}, "<Up>",    "<nop>")
map({"n", "i"}, "<Down>",  "<nop>")

-- x should not copy a single character into the clipboard
map("n", "x", [["_x]])

-- This makes the current match more visible
-- and also centers the match vertically in the buffer
map("n", "n", "n:call HLNext()<CR>zz", { silent = true })
map("n", "N", "N:call HLNext()<CR>zz", { silent = true })

map("t", "<Esc>", "<C-\\><C-n>")
map("t", "<C-v><Esc>", "<Esc>")

--Turn off highlights from search
map("n","<Leader>nh", ":noh<CR>", { silent = true })
map("n","<C-c>", ":noh<CR>", { silent = true })

--Find and replace (with 'magic')
map("n", "<Leader>r", ":%s/\\v")
map("n", "<Space>rr", ":%s/\\v")

--  old way
--    map("n", "<Leader>do", ":r! date<CR>", { silent = true })
--  new way
map("n", "<Leader>dd", "o<Esc>18i#<Esc>3a<Space><Esc>o<Esc>:.!date<CR>kJ3A<Space><Esc>18a#<Esc><CR>")

-- auto-reform ugly json
map("n", "<Leader>rj", ":%!python3 -mjson.tool<CR>")

-- remove trailing whitespace
map("n", "<Leader>rw", ":%s/\\v\\s+$//<CR>", { silent = true })

-- toggle ColorColumn
map('n', '<Leader>co', fns.toggle_opt('colorcolumn', 'wo', '79', '0'))

map("n", "<Space>.", ":BufferLineCycleNext<CR>", { silent = true })
map("n", "<Space>,", ":BufferLineCyclePrev<CR>", { silent = true })

map("n", "<Leader>vt", ":vsplit | terminal <CR> i")
map("n", "<Leader>ht", ":split | terminal  <CR> i")


map("n", "<Space>q", ":bd  <CR> i")



-- -- snipmate
-- map("i", "<C-J>", "<Plug>snipMateNextOrTrigger")
-- 
-- 
-- map("n", "<C-S>", "<C-W>")
-- 
-- 
-- map({"t", ""}, "<M-k>", "<C-\\><C-n><C-w>k")
-- map({"t", ""}, "<M-j>", "<C-\\><C-n><C-w>j")
-- 
-- -----------------------------------------------------
-- ---- LEADER MAPS ------------------------------------
-- 
-- 
-- map("n", "<Leader>m", ":FloatermToggle<CR>")
-- map("n", "<Leader>M", ":FloatermNew --cwd=<root><CR>")
-- 