require 'vix.options'

local tmpcmd = 'source ' .. vim.fn.stdpath('config') .. '/residual-vimscript.vim'
vim.cmd(tmpcmd)

require 'vix.plugins'
require 'vix.commands'
require 'vix.keymaps'
require 'vix.autocmds'

require 'vix.plugins.devicons'
require 'vix.plugins.lualine'
require 'vix.plugins.scrollbar'
require 'vix.plugins.neoscroll'
require 'vix.plugins.telescope'
require 'vix.plugins.bufferline'
require 'vix.plugins.nvimtree'
require 'vix.plugins.colorizer'
