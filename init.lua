require 'vix.options'
require 'vix.lazy'

local tmpcmd = 'source ' .. vim.fn.stdpath('config') .. '/residual-vimscript.vim'
vim.cmd(tmpcmd)

require 'vix.commands'
require 'vix.keymaps'
require 'vix.autocmds'

