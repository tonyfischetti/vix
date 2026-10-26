
local vixgroup = vim.api.nvim_create_augroup("vix_cmds", { clear = true })

-- filetype overrides. everything neovim already detects the same way
-- (.lisp/.lsp/.asd, .hy, .ino, Makefile, .tsx) is left to it; these are
-- the ones where we want something different
vim.filetype.add({
  extension = {
    ejs = "html",             -- neovim has no ejs detection
    jsx = "typescriptreact",  -- neovim: javascriptreact
    -- deliberate: plain .ts files get the tsx syntax stack as well; the
    -- lcars colorscheme is tuned to its highlight groups (see the
    -- TypeScript notes in README before changing)
    ts  = "typescriptreact",  -- neovim: typescript
  },
  filename = {
    ["Makefile.am"] = "make", -- neovim: automake
  },
})

-- typescript-vim ships an ftdetect autocmd that forces ft=typescript on
-- *.ts. it is only registered once that plugin has loaded (first
-- typescriptreact buffer), after which it would undo the override above
-- for every later .ts file. so instead of racing it, react to it: any
-- .ts buffer that ends up as `typescript` is flipped back
vim.api.nvim_create_autocmd("FileType", {
    group = vixgroup,
    pattern = "typescript",
    nested = true,  -- so the FileType typescriptreact event fires too
    callback = function(a)
        if a.file:match("%.ts$") then
            vim.bo[a.buf].filetype = "typescriptreact"
        end
    end,
})

vim.api.nvim_create_autocmd("FileType", {
    group = vixgroup,
    pattern = "lisp",
    callback = function()
        vim.bo.omnifunc = "syntaxcomplete#Complete"
    end
})

vim.api.nvim_create_autocmd("FileType", {
    group = vixgroup,
    pattern = "r",
    callback = function()
        vim.opt_local.iskeyword:append(".")
        vim.bo.omnifunc = "syntaxcomplete#Complete"
    end
})

-- pick up files changed outside neovim (dropbox, the obsidian app, the
-- phone) as soon as the terminal regains focus or a buffer is entered,
-- instead of whenever neovim next happens to check. 'autoread' (on by
-- default) does the reload when the buffer has no changes of its own;
-- otherwise you get the usual prompt. inside tmux, FocusGained needs
-- `set -g focus-events on` in tmux.conf; BufEnter works regardless
vim.api.nvim_create_autocmd({ "FocusGained", "BufEnter" }, {
    group = vixgroup,
    callback = function()
        if vim.fn.getcmdwintype() == "" and vim.fn.mode() ~= "c" then
            vim.cmd("checktime")
        end
    end
})
