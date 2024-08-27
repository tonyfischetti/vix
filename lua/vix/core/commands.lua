
vim.api.nvim_create_user_command("WQ", "wq", {})
vim.api.nvim_create_user_command("Wq", "wq", {})
vim.api.nvim_create_user_command("W", "w", {})
vim.api.nvim_create_user_command("Q", "q", {})

vim.api.nvim_create_user_command("Sep", ":normal! i<args> --------------------------------------------------------------- <args><ESC>o", { nargs = 1 })

