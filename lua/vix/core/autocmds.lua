
local vixgroup = vim.api.nvim_create_augroup("vix_cmds", { clear = true })

vim.api.nvim_create_autocmd({"BufNewFile", "BufRead"}, {
    group = vixgroup,
    pattern = { "*.lisp", "*.lsp", "*.asd"},
    command = "set ft=lisp"
})

vim.api.nvim_create_autocmd({"BufNewFile", "BufRead"}, {
    group = vixgroup,
    pattern = "*.hy",
    command = "set ft=hy"
})

vim.api.nvim_create_autocmd({"BufNewFile", "BufRead"}, {
    group = vixgroup,
    pattern = "*.ino",
    command = "set ft=arduino"
})

vim.api.nvim_create_autocmd({"BufNewFile", "BufRead"}, {
    group = vixgroup,
    pattern = "Makefile.am",
    command = "set ft=make"
})

vim.api.nvim_create_autocmd({"BufNewFile", "BufRead"}, {
    group = vixgroup,
    pattern = "Makefile",
    command = "set ft=make"
})

vim.api.nvim_create_autocmd({"BufNewFile", "BufRead"}, {
    group = vixgroup,
    pattern = "*.ejs",
    command = "set ft=html"
})

vim.api.nvim_create_autocmd({"BufNewFile", "BufRead"}, {
    group = vixgroup,
    pattern = { "*.tsx", "*.jsx" },
    command = "set ft=typescriptreact"
})

-- I think it works even better that the regular ones
vim.api.nvim_create_autocmd({"BufNewFile", "BufRead"}, {
    group = vixgroup,
    pattern = { "*.ts" },
    command = "set ft=typescriptreact"
})

-- vim.api.nvim_create_autocmd({"BufNewFile", "BufRead"}, {
--     group = vixgroup,
--     pattern = { "*.cpp", "*.hpp", "*.cc" },
--     command = "setlocal omnifunc=syntaxcomplete#Complete"
-- })
--
-- vim.api.nvim_create_autocmd("BufEnter", {
--     command = [[set fo-=c fo-=r fo-=o]]
-- })

