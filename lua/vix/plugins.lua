
local Plug = vim.fn['plug#']

local plugloc = vim.fn.stdpath("config") .. '/plugged'

vim.call('plug#begin', plugloc)

Plug 'tomtom/tlib_vim'
Plug 'MarcWeber/vim-addon-mw-utils'
Plug 'nvim-lualine/lualine.nvim'
Plug 'kyazdani42/nvim-web-devicons'
Plug 'tomtom/tcomment_vim'
Plug 'lifepillar/vim-mucomplete'
Plug 'garbas/vim-snipmate'
Plug 'jpalardy/vim-slime'
Plug 'justinmk/vim-sneak'
Plug 'vim-pandoc/vim-pandoc-syntax'
Plug('wlangstroth/vim-racket',          {['for'] = 'racket'})
Plug('maverickg/stan.vim',              {['for'] = 'stan'})
Plug('TovarishFin/vim-solidity',        {['for'] = 'solidity'})
Plug('pangloss/vim-javascript',         {['for'] = 'javascript'})
Plug('leafgarland/typescript-vim',      {['for'] = 'typescript'})
Plug('mattn/emmet-vim',                 {['for'] = 'html'})
Plug('pprovost/vim-ps1',                {['for'] = 'ps1'})
Plug('elzr/vim-json',                   {['for'] = 'json'})
Plug('bfrg/vim-cpp-modern',             {['for'] = 'cpp'})
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
Plug 'nvim-lua/plenary.nvim'
Plug('nvim-telescope/telescope.nvim',   { ['tag'] = '0.1.0' })
Plug 'nvim-telescope/telescope-symbols.nvim'
Plug 'akinsho/bufferline.nvim'
Plug('nvim-tree/nvim-tree.lua',         { ['commit'] = '78a9ca5ed6557f29cd'})
Plug 'voldikss/vim-floaterm'
Plug 'norcalli/nvim-colorizer.lua'

-- don't load fzf native on window$
if vim.fn.has("win32") == 0 then
    Plug('nvim-telescope/telescope-fzf-native.nvim', { ['do'] = 'make' })
end

vim.call('plug#end')
