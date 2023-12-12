local builtin = require('telescope.builtin')
local actions = require("telescope.actions")

require("telescope").setup{
    defaults = {
        mappings = {
            i = {
                ["<ESC>"] = actions.close,
                ["<C-j>"] = actions.move_selection_next,
                ["<C-k>"] = actions.move_selection_previous,
            },

        },
        sorting_strategy   = "ascending",
        layout_config = {
            prompt_position = "top",
        }
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

-- don't load this on window$
if vim.fn.executable("fzf") == 0 then
    require('telescope').load_extension('fzf')
end

-- vim.keymap.set('n', '<Leader>ff', builtin.find_files, {})
vim.keymap.set('n', '<Leader>f', builtin.git_files, {})
vim.keymap.set('n', '<Leader>F', builtin.find_files, {})
vim.keymap.set('n', '<Leader>c', builtin.colorscheme, {})
vim.keymap.set("n", "<Leader>E", builtin.symbols, {})
vim.keymap.set('n', '<leader>b', builtin.buffers, {})

