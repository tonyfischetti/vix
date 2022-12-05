vim.api.nvim_set_keymap('n', '<C-p>',
    "<cmd>lua require('fzf-lua').files()<CR>",
    { noremap = true, silent = true })
