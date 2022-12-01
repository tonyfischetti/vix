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
          -- `hidden = true` will still show the inside of `.git/` as it's not `.gitignore`d.
          find_command = { "ack", "-f" },
      },
  }
}


vim.keymap.set('n', '<Leader>ff', builtin.find_files, {})
vim.keymap.set('n', '<Leader>co', builtin.colorscheme, {})

--require'telescope.builtin'.symbols{ sources = {'emoji', 'kaomoji', 'gitmoji'} }

vim.keymap.set("n", "<Leader>ee", builtin.symbols, {})
-- vim.keymap.set("n", "<Leader>ee", builtin.symbols, { sources = {'math'} })
-- vim.keymap.set("n", "<Leader>ee", require'telescope.builtin'.symbols{ sources = {'emoji', 'kaomoji', 'gitmoji'} })
