
require 'vix.options'
require 'vix.plugins'
require 'vix.commands'
require 'vix.keymaps'

require 'vix.lualine'
require 'vix.hop'
require 'vix.scrollbar'
require 'vix.neoscroll'
require 'vix.telescope'

tmpcmd = 'source ' .. vim.fn.stdpath('config') .. '/residual-vimscript.vim'
vim.cmd(tmpcmd)

