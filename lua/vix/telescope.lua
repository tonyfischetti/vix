local builtin = require('telescope.builtin')
local actions = require("telescope.actions")

require("telescope").setup{
    defaults = {
        mappings = {
            i = {
                ["<ESC>"] = actions.close
            },
        },
    },
    pickers = {
        find_files = {
            find_command = { "ack", "-f" },
        },
    },
    extensions = {
        fzf = {
            fuzzy = true,
            override_generic_sorter = true,
            override_file_sorter = true,
            case_mode = "smart_case",
        }
    }
}

require('telescope').load_extension('fzf')

vim.keymap.set('n', '<Leader>ff', builtin.find_files, {})
vim.keymap.set('n', '<Leader>co', builtin.colorscheme, {})
vim.keymap.set("n", "<Leader>ee", builtin.symbols, {})

