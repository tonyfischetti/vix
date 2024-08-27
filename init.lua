require 'vix.global-options'
require 'vix.lazy'

local tmpcmd = 'source ' .. vim.fn.stdpath('config') .. '/residual-vimscript.vim'
vim.cmd(tmpcmd)

require('vix.core')
require('vix.final')

