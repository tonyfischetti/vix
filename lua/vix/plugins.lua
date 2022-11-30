
local Plug = vim.fn['plug#']

plugloc = vim.fn.stdpath("config") .. '/plugged'

vim.call('plug#begin', plugloc)

Plug 'tomtom/tlib_vim'
Plug 'MarcWeber/vim-addon-mw-utils'
Plug 'nvim-lualine/lualine.nvim'
Plug 'kyazdani42/nvim-web-devicons'
Plug 'tomtom/tcomment_vim'
Plug 'garbas/vim-snipmate'
Plug 'jpalardy/vim-slime'
Plug 't9md/vim-smalls'
Plug 'phaazon/hop.nvim'
Plug 'vim-pandoc/vim-pandoc-syntax'
Plug 'lifepillar/vim-mucomplete'
Plug('wlangstroth/vim-racket',          {['for'] = 'racket'})
Plug('maverickg/stan.vim',              {['for'] = 'stan'})
Plug('TovarishFin/vim-solidity',        {['for'] = 'solidity'})
Plug('pangloss/vim-javascript',         {['for'] = 'javascript'})
Plug('leafgarland/typescript-vim',      {['for'] = 'typescript'})
Plug('mattn/emmet-vim',                 {['for'] = 'html'})
Plug('pprovost/vim-ps1',                {['for'] = 'ps1'})
Plug 'elzr/vim-json'
Plug 'junegunn/goyo.vim'
Plug 'losingkeys/vim-niji'
Plug 'karb94/neoscroll.nvim'
Plug 'petertriho/nvim-scrollbar'
Plug 'dracula/vim'
Plug 'EdenEast/nightfox.nvim'
Plug 'marko-cerovac/material.nvim'
Plug 'folke/tokyonight.nvim'
Plug 'whatyouhide/vim-gotham'

Plug 'dstein64/vim-startuptime'


vim.call('plug#end')


