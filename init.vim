""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                                                                  "
"                                                                  "
"     Tony Fischetti's .vimrc                                      "
"                                                                  "
"                                tony.fischetti@gmail.com          "
"                                                                  "
"                                                                  "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""


set nocompatible

set history=700
set autoread
set ruler
set cmdheight=1
set cmdwinheight=13
set hid
set hlsearch
set incsearch
set showmatch
set nowrap
set backspace=2
set backspace=indent,eol,start
set autochdir
set clipboard=unnamedplus
set title
set noswapfile
set ttyfast
set laststatus=2
set encoding=utf8
set scrolloff=5
set lbr
set colorcolumn=79
set expandtab
set smarttab
set shiftwidth=4
set tabstop=4
set softtabstop=4
set number
set foldmethod=indent
set foldnestmax=10
set nofoldenable
set foldlevel=1
set modeline
set termguicolors
set formatprg=par\ -w75r "rj
set updatetime=300
set ignorecase
set smartcase

" - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - "

let tmp_plugged_path = '~/.config/nvim/plugged'
if has("win32")
    let tmp_plugged_path = "~/AppData/Local/nvim/plugged"
endif

" specify directory for plugins
call plug#begin(tmp_plugged_path)

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
Plug 'wlangstroth/vim-racket'
Plug 'maverickg/stan.vim'
Plug 'TovarishFin/vim-solidity'
Plug 'pangloss/vim-javascript'
Plug 'leafgarland/typescript-vim'
Plug 'elzr/vim-json'
Plug 'mattn/emmet-vim'
Plug 'pprovost/vim-ps1'
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

" initialize plugin system
call plug#end()

" - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - "

colorscheme lcars
set background=dark

set guifont=Monaco\ for\ Powerline\ Nerd\ Font\ Complete:h13
set guioptions-=L
set guioptions-=r

syntax on
filetype plugin on
filetype plugin indent on

set mouse=a

" Find and replace
" (with 'magic")
nmap <Leader>fr :%s/\v

" repeat last command
nmap <Leader>rt @:<CR>

" toggle just the color column
nmap <silent> <Leader>cc :call ColorColumn()<CR>

" insert date right into document
nmap <silent> <Leader>dd :r! date<CR>

" function to toggle color column
function! ColorColumn()
  if empty(&colorcolumn)
    if empty(&textwidth)
      echo "colorcolumn=79"
      setlocal colorcolumn=79
    else
      echo "colorcolumn=+1 (" . (&textwidth + 1) . ")"
      setlocal colorcolumn=+1
    endif
  else
    echo "colorcolumn="
    setlocal colorcolumn=
  endif
endfunction


" I make mistake sometimes
:command WQ wq
:command Wq wq
:command W w
:command Q q

" gotta do it the vim way
map <Left> <Nop>
map <Right> <Nop>
map <Up> <Nop>
map <Down> <Nop>

" Easier Redo (u/U = Undo/Redo)
nnoremap U <C-R>

" Turn off highlights from search
nmap <silent> <Leader>nh :noh<CR>

" No Ex mode
nnoremap Q <nop>

" Hop (formerly EasyMotion) stuff
nmap <Leader>er :HopWord<CR>
nmap S :HopWord<CR>

" auto-reform ugly json
nmap <Leader>rj :%!python3 -mjson.tool<CR>

" highlight trailing whitespace
nmap <silent> <Leader>tw :/\v\s+$/<CR>
"
" remove trailing whitespace
nmap <silent> <Leader>rw :%s/\v\s+$//<CR>

" Set visual mode indent
vnoremap < <gv
vnoremap > >gv

" Allows for hashtag comments to be inserted on a visual block
" (at the beginning of the line) with a question mark
vnoremap ? :TComment<CR>

" remove auto string apostrophe concealing in json
let g:vim_json_syntax_conceal = 0

function! NotepadMode()
    set wrap
    set spell
    Goyo
endfunction

" put into 'notepad mode'
nmap <silent> <Leader>nm :call NotepadMode()<CR>

autocmd! User GoyoEnter call <SID>goyo_enter()
autocmd! User GoyoLeave call <SID>goyo_leave()

function! s:goyo_enter()
  let b:quitting = 0
  let b:quitting_bang = 0
  autocmd QuitPre <buffer> let b:quitting = 1
  cabbrev <buffer> q! let b:quitting_bang = 1 <bar> q!
endfunction

function! s:goyo_leave()
  if b:quitting && len(filter(range(1, bufnr('$')), 'buflisted(v:val)')) == 1
    if b:quitting_bang
      qa!
    else
      qa
    endif
  endif
endfunction

let g:goyo_width=80
function! HLNext()
    highlight BlackOnWhite ctermfg=black ctermbg=white
    let [bufnum, lnum, col, off] = getpos('.')
    let matchlen = strlen(matchstr(strpart(getline('.'),col-1),@/))
    let target_pat = '\c\%#'.@/
    let ring = matchadd('BlackOnWhite', target_pat, 101)
    redraw
endfunction

" This makes the current match more visible
" and also centers the match vertically in the buffer
nnoremap <silent> n   n:call HLNext()<cr>zz
nnoremap <silent> N   N:call HLNext()<cr>zz


" easy map to turn back on rainbow parens after color scheme change
nmap <silent> <Leader>rp :call niji#highlight()<CR>
let g:niji_matching_filetypes = ['lisp', 'scheme', 'clojure', 'racket']

command -nargs=1 Sep :normal! i<args> --------------------------------------------------------------- <args><ESC>o

imap <C-O><C-O> •
imap <C-O><C-B> «
imap <C-O><C-N> »

let g:user_emmet_leader_key=','

" Small motion plugin
nmap s <Plug>(smalls)

set omnifunc=syntaxcomplete#Complete

set completeopt+=longest,menuone,noselect
set completeopt-=preview

let g:mucomplete#chains = {}
let g:mucomplete#chains.default = ['path', 'omni', 'keyn', 'dict', 'uspl']

" non-legacy snipmate parser
let g:snipMate = { 'snippet_version' : 1 }

imap <C-J> <Plug>snipMateNextOrTrigger
smap <C-J> <Plug>snipMateNextOrTrigger


" ------------------
" SLIME STUFF
let g:slime_paste_file = "~/.slime_paste"

" this function gets around the skipping-empty-lines problem
function! SlimeOneLine()
    let line = getline('.')
    let length = len(line)
    let linenumber = line(".") + 1
    if length
        execute "normal \<C-O>"
    endif
    :call cursor(linenumber, 0)
endfunction

function! SlimeOneLineSamePlace()
    let line = getline('.')
    let length = len(line)
    let linenumber = line(".") + 1
    let curpos = getpos('.')
    if length
        execute "normal \<C-O>"
    endif
    " :call cursor(line)
    " :call cursor(curpos[1]-1, curpos[2]-1)
    " :call setpos(".", curpos)
endfunction

" this gets around the problem where sending large
" selections messes up the R REPL
function! SlimeMultiLine()
    :call SlimeOneLine()
    ":sleep 10m
endfunction

let g:slime_target = "tmux"
let g:slime_default_config = {"socket_name": "default", "target_pane": "%1"}
let g:slime_no_mappings = 1
vmap <silent> <C-Space> :call SlimeMultiLine()<CR>
nmap <silent> <C-O> <Plug>SlimeLineSend
nmap <silent> <C-Space> :call SlimeOneLine()<CR>
xmap <silent> <C-X><C-X> <Plug>SlimeRegionSend

command -nargs=1 SS :SlimeSend1 <args>
nmap <silent> <C-L> :SlimeSend1 <CR>

imap <silent> <C-Space> <Esc>:call SlimeOneLineSamePlace()<CR>a


nmap <silent> <Leader>hg :echo "hi<" . synIDattr(synID(line("."),col("."),1),"name") . '> trans<'
\ . synIDattr(synID(line("."),col("."),0),"name") . "> lo<"
\ . synIDattr(synIDtrans(synID(line("."),col("."),1)),"name") . ">"<CR>

au BufNewFile,BufRead,BufReadPost *.ps1 set ft=ps1
au BufNewFile,BufRead *.lisp,*.lsp,*asd set ft=lisp
au BufNewFile,BufRead *.hy    set ft=hy
au BufNewFile,BufRead *.yaml,*.yml    set ft=yaml

" Use better syntax highlighting for YAML
au BufNewFile,BufRead *.yaml,*.yml so ~/.vim/syntax/yaml.vim

augroup pandoc_syntax
    au! BufNewFile,BufFilePre,BufRead *.md set filetype=markdown.pandoc
augroup END

let g:material_style = "palenight"

lua require('neoscroll').setup({ hide_cursor = true })

lua require("scrollbar").setup({ handle = { color = "#4E4E4E", cterm = 239, highlight = "ColorColumn", hide_if_all_visible = true }})


" easy map to alternate favorite color schemes
nmap <silent> <Leader>mo :color molokai<CR>
nmap <silent> <Leader>fl :color flattr<CR>
nmap <silent> <Leader>dr :color dracula<CR>
nmap <silent> <Leader>tf :color terafox<CR>
nmap <silent> <Leader>ma :color material<CR>
nmap <silent> <Leader>go :color gotham256<CR>
nmap <silent> <Leader>tn :color tokyonight-night<CR>
nmap <silent> <Leader>ei :color Tomorrow-Night-Eighties<CR>

tnoremap <Esc> <C-\><C-n>
map <C-S> <C-W>

lua << END
local colors = {
  blue   = '#80a0ff',
  cyan   = '#79dac8',
  -- black  = '#080808',
  black  = '#121212',
  white  = '#c6c6c6',
  red    = '#ff5189',
  violet = '#d183e8',
  grey   = '#303030',

  salmon = '#ffaf87',
  lavender = '#8787d7',
  purplepink = '#d787d7'
}

local bubbles_theme = {
  normal = {
    a = { fg = colors.black, bg = colors.lavender },
    b = { fg = colors.white, bg = colors.grey },
    c = { fg = colors.black, bg = colors.black },
  },

  insert = { a = { fg = colors.black, bg = colors.salmon } },
  visual = { a = { fg = colors.black, bg = colors.cyan } },
  replace = { a = { fg = colors.black, bg = colors.red } },

  inactive = {
    -- a = { fg = colors.white, bg = colors.black },
    -- b = { fg = colors.white, bg = colors.black },
    a = { fg = colors.black, bg = colors.black },
    b = { fg = colors.black, bg = colors.black },
    c = { fg = colors.black, bg = colors.black },
  },
}

require('lualine').setup {
  options = {
    theme = bubbles_theme,
    component_separators = '|',
    section_separators = { left = '', right = '' },
  },
  sections = {
    lualine_a = {
      { 'mode', separator = { left = '', right = ''}, right_padding = 0 },
    },
    lualine_b = { 'filename', 'branch' },
    lualine_c = { 'fileformat' },
    lualine_x = {},
    lualine_y = { 'filetype', 'progress' },
    lualine_z = {
      { 'location', separator = { right = '' }, left_padding = 2 },
    },
  },
  inactive_sections = {
    lualine_a = { 'filename' },
    lualine_b = {},
    lualine_c = {},
    lualine_x = {},
    lualine_y = {},
    lualine_z = { 'location' },
  },
  tabline = {},
  extensions = {},
}

local hop = require('hop').setup {}


END
