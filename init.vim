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
set cmdheight=2
set cmdwinheight=13
set hid
set hlsearch
set incsearch
set showmatch
set nowrap
set backspace=2
set backspace=indent,eol,start
set autochdir
let os = substitute(system('uname'), "\n", "", "")
if os == "Darwin"
    set clipboard+=unnamed
elseif os == "Linux"
    set clipboard=unnamedplus
else
    set clipboard+=unnamed
endif
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
set number
set foldmethod=indent
set foldnestmax=10
set nofoldenable
set foldlevel=1
set modeline
set t_Co=256
set formatprg=par\ -w75r "rj
set updatetime=300

" - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - "

" specify directory for plugins
call plug#begin('~/.config/nvim/plugged')

Plug 'tomtom/tlib_vim'
Plug 'MarcWeber/vim-addon-mw-utils'
Plug 'vim-airline/vim-airline'
Plug 'tonyfischetti/vim-airline-themes'
Plug 'tomtom/tcomment_vim'
Plug 'garbas/vim-snipmate'
Plug 'jpalardy/vim-slime'
Plug 't9md/vim-smalls'
Plug 'easymotion/vim-easymotion'
Plug 'vim-pandoc/vim-pandoc-syntax'
Plug 'lifepillar/vim-mucomplete'
Plug 'neoclide/coc.nvim'
Plug 'wlangstroth/vim-racket'
Plug 'whatyouhide/vim-gotham'
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
Plug 'dracula/vim'
Plug 'EdenEast/nightfox.nvim'
Plug 'marko-cerovac/material.nvim'

" initialize plugin system
call plug#end()

" - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - "

colorscheme lcars
" colorscheme molokai
set background=dark

if has("gui_running")
    if has("gui_macvim")
        set guifont=Monaco\ for\ Powerline\ Nerd\ Font\ Complete:h13
        set transparency=2
        " colorscheme molokai
        colorscheme lcars
        set guioptions-=L
        set guioptions-=r
    endif
    if has("gui_gtk2")
        set guifont=Monaco\ for\ Powerline\ Nerd\ Font\ Complete:h16
        set guioptions-=m
        set guioptions-=L
        set guioptions-=r
        set guioptions-=T
    endif
    if has("gui_gtk3")
        set guifont=Monaco\ for\ Powerline\ Nerd\ Font\ Complete:h16
        set guioptions-=m
        set guioptions-=L
        set guioptions-=r
        set guioptions-=T
    endif
    if has("gui_win32")
        set guifont=Inconsolata\ for\ Powerline:h13
        set guioptions=m
    endif
endif

syntax on
filetype plugin on
filetype plugin indent on

if has("mouse")
    set mouse=a
endif

" easy window switching
nmap <Leader>sw <C-W><C-W>

" Find and replace
" (with 'magic")
nmap <Leader>fr :%s/\v

" repeat last command
nmap <Leader>rt @:<CR>

" toggle line wrap, also toggles the color column
nmap <silent> <Leader>tw :set wrap!<CR>:call ColorColumn()<CR>

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

" Resize current buffer to 85 columns
nmap <Leader>nb 85<C-W>\|

" No Ex mode
nnoremap Q <nop>

" rotate windows
nmap <Leader>rw <C-W>r

" EasyMotion stuff
nmap <Leader>er <Leader><Leader>w
nmap S <Leader><Leader>w

" auto-reform ugly json
nmap <Leader>rj :%!python3 -mjson.tool<CR>

" highlight trailing whitespace
nmap <silent> <Leader>tw :/\v\s+$/<CR>
"
" remove trailing whitespace
nmap <silent> <Leader>rw :%s/\v\s+$//<CR>

" easy resizing of windows
" resize height
nmap + <C-W>+
nmap _ <C-W>-
" resize width
nmap = <C-W>>
nmap - <C-W><

" Set visual mode indent
:vnoremap < <gv
:vnoremap > >gv

" Allows for hashtag comments to be inserted on a visual block
" (at the beginning of the line) with a question mark
vnoremap ? :TComment<CR>

" remove auto string apostrophe concealing in json
let g:vim_json_syntax_conceal = 0

" airline overrides
let g:airline_powerline_fonts = 1

let g:airline_theme='lcars'

let NERDTreeIgnore = ['\.pyc$', '\.pyo$']
nmap <silent> <Leader>nt :NERDTreeToggle<CR>

nmap <silent> <Leader>tb :TagbarToggle<CR>

function! ChangeSize(direction)
    if has("gui_running")
        if exists("&guifont")
            if (len(&guifont) > 0)
                let thesplit = split(&guifont, ":")
                let fontname = thesplit[0]
                let rawsize = thesplit[1]
                let numsize = split(rawsize, "h")[0]
                if (a:direction > 0)
                    let numsize = numsize+1
                elseif (a:direction < 0)
                    let numsize = numsize-1
                endif
                let newfont = fontname . ":h" . numsize
                let &guifont = newfont
            endif
        endif
    endif
endfunction

function! MakeFontBigger()
    call ChangeSize(1)
endfunction

function! MakeFontSmaller()
    call ChangeSize(-1)
endfunction

nmap <silent> <Leader>bb :call MakeFontBigger()<CR>
nmap <silent> <Leader>ss :call MakeFontSmaller()<CR>

function! NotepadMode()
    set wrap
    set spell
    " call ColorColumn()
    " colorscheme soft
    Goyo
    if has("gui_running")
        if exists("&guifont")
            if (len(&guifont) > 0)
                call MakeFontBigger()
                call MakeFontBigger()
            endif
        endif
    endif
endfunction

" put into 'notepad mode'
nmap <silent> <Leader>nm :call NotepadMode()<CR>

:command -nargs=1 Width :set textwidth=<args>

autocmd! User GoyoEnter call <SID>goyo_enter()
autocmd! User GoyoLeave call <SID>goyo_leave()

function! s:goyo_enter()
  " :color pencil
  let b:quitting = 0
  let b:quitting_bang = 0
  autocmd QuitPre <buffer> let b:quitting = 1
  cabbrev <buffer> q! let b:quitting_bang = 1 <bar> q!
endfunction

function! s:goyo_leave()
  " Quit Vim if this is the only remaining buffer
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

" set omnifunc=ccomplete#Complete
set omnifunc=syntaxcomplete#Complete

set completeopt+=longest,menuone,noselect

inoremap <silent><expr> <CR> coc#pum#visible() ? coc#pum#confirm() : "\<CR>"

let g:mucomplete#chains = {}
let g:mucomplete#chains.default = ['path', 'omni', 'keyn', 'dict', 'uspl']

" non-legacy snipmate parser
let g:snipMate = { 'snippet_version' : 1 }

imap <C-J> <Plug>snipMateNextOrTrigger
smap <C-J> <Plug>snipMateNextOrTrigger


" SLIME STUFF
" Vim slime is (cli).vimrc only

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

nmap <silent> <A-Space> :call SlimeOneLine()<CR>
nmap <silent> <M-Space> :call SlimeOneLine()<CR>
vmap <silent> <A-Space> :call SlimeOneLine()<CR>
vmap <silent> <M-Space> :call SlimeOneLine()<CR>

:command -nargs=1 SS :SlimeSend1 <args>
nmap <silent> <M-D> :SlimeSend1 <CR>
nmap <silent> <C-L> :SlimeSend1 <CR>

imap <silent> <C-Space> <Esc>:call SlimeOneLineSamePlace()<CR>a

" select block in R
" nmap <silent> <Leader>bb /^}\v%0
" run block in R
nmap <silent> <Leader>rr /^}v%0<C-Space>j<Leader>nh

:command -nargs=0 RCopyLastValue :SlimeSend1 copy_last_value()

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

nmap <leader>rr <Plug>(coc-rename)
command! -nargs=0 Format :call CocActionAsync('format')

let g:material_style = "palenight"

lua require('neoscroll').setup({ hide_cursor = true })


" easy map to alternate favorite color schemes
nmap <silent> <Leader>mo :color molokai<CR>
nmap <silent> <Leader>fl :color flattr<CR>
nmap <silent> <Leader>dr :color dracula<CR>
nmap <silent> <Leader>tf :color terafox<CR>
nmap <silent> <Leader>cf :color carbonfox<CR>
nmap <silent> <Leader>ma :color material<CR>
nmap <silent> <Leader>go :color gotham256<CR>
