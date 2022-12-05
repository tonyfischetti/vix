local builtin = require('telescope.builtin')
local actions = require("telescope.actions")

require("telescope").setup{
    defaults = {
        mappings = {
            i = {
                ["<ESC>"] = actions.close
            },
        },
        layout_config = {
            -- prompt_position = "top",
            -- mirror = false,
            -- anchor = "N"
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
if vim.fn.has("win32") == 0 then
    require('telescope').load_extension('fzf')
end

vim.keymap.set('n', '<Leader>ff', builtin.find_files, {})
vim.keymap.set('n', '<Leader>co', builtin.colorscheme, {})
vim.keymap.set("n", "<Leader>ee", builtin.symbols, {})

