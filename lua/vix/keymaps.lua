
local map = vim.keymap.set

map("i","<C-O><C-O>", "•")
map("i","<C-O><C-B>", "«")
map("i","<C-O><C-N>", "»")

--hop things
map("n","<Leader>er", ":HopWord<CR>")
map("n","S", ":HopWord<CR>")

--Set visual mode indent
map("v","<", "<gv", { noremap = true })
map("v",">", ">gv", { noremap = true })

--tComment
map("v","?", ":TComment<CR>", { noremap = true })

--no Ex mode
map("n","Q", "<nop>", { noremap = true })

--Easier Redo (u/U = Undo/Redo)
map("n","U", "<C-R>", { noremap = true })

--Turn off highlights from search
map("n","<Leader>nh", ":noh<CR>", { silent = true })

--gotta do it the vim way
map("n", "<Left>",  "<nop>", { noremap = true })
map("n", "<Right>", "<nop>", { noremap = true })
map("n", "<Up>",    "<nop>", { noremap = true })
map("n", "<Down>",  "<nop>", { noremap = true })
map("i", "<Left>",  "<nop>", { noremap = true })
map("i", "<Right>", "<nop>", { noremap = true })
map("i", "<Up>",    "<nop>", { noremap = true })
map("i", "<Down>",  "<nop>", { noremap = true })

--Find and replace (with 'magic')
map("n", "<Leader>fr", ":%s/\\v")

-- toggle just the color column
map("n", "<Leader>cc", ":call ColorColumn()<CR>", { silent = true })

-- " insert date right into document
-- nmap <silent> <Leader>dd :r! date<CR>
map("n", "<Leader>dd", ":r! date<CR>", { silent = true })

-- snipmate
map("i", "<C-J>", "<Plug>snipMateNextOrTrigger")
map("s", "<C-J>", "<Plug>snipMateNextOrTrigger")


-- auto-reform ugly json
map("n", "<Leader>rj", ":%!python3 -mjson.tool<CR>")

-- highlight trailing whitespace
map("n", "<Leader>tw", ":/\\v\\s+$/<CR>", { silent = true })

-- remove trailing whitespace
map("n", "<Leader>rw", ":%s/\\v\\s+$//<CR>", { silent = true })

-- Small motion plugin
map("n", "s", "<Plug>(smalls)")


-- This makes the current match more visible
-- and also centers the match vertically in the buffer
map("n", "n", "n:call HLNext()<CR>zz", { noremap = true, silent = true })
map("n", "N", "N:call HLNext()<CR>zz", { noremap = true, silent = true })

-- easy map to turn back on rainbow parens after color scheme change
map("n", "<Leader>rp", ":call niji#highlight()<CR>", { silent = true })

-- easy map to alternate favorite color schemes
map("n", "<Leader>mo", ":color molokai<CR>", { silent = true })
map("n", "<Leader>fl", ":color flattr<CR>", { silent = true })
map("n", "<Leader>dr", ":color dracula<CR>", { silent = true })
map("n", "<Leader>tf", ":color terafox<CR>", { silent = true })
map("n", "<Leader>ma", ":color material<CR>", { silent = true })
map("n", "<Leader>go", ":color gotham256<CR>", { silent = true })
map("n", "<Leader>tn", ":color tokyonight-night<CR>", { silent = true })
map("n", "<Leader>ei", ":color Tomorrow-Night-Eighties<CR>", { silent = true })

map("t", "<Esc>", "<C-\\><C-n>", { noremap = true })
map("n", "<C-S>", "<C-W>")

-- x should not copy a single character into the clipboard
map("n", "x", [["_x]], { noremap = true })
