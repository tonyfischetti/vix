
vim.api.nvim_create_user_command("WQ", "wq", {})
vim.api.nvim_create_user_command("Wq", "wq", {})
vim.api.nvim_create_user_command("W", "w", {})
vim.api.nvim_create_user_command("Q", "q", {})

vim.api.nvim_create_user_command("PI", "PlugInstall", {})
vim.api.nvim_create_user_command("PC", "PlugClean", {})
vim.api.nvim_create_user_command("PU", "PlugUpdate", {})

vim.api.nvim_create_user_command("Sep", ":normal! i<args> --------------------------------------------------------------- <args><ESC>o", { nargs = 1 })

vim.api.nvim_create_user_command("Tree", "NvimTreeToggle", {})

vim.api.nvim_create_user_command("Make", ':FloatermNew --cwd=<root>', {})
