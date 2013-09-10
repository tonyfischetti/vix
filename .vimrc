execute pathogen#infect()





set nocompatible
set history=700
set autoread
set ruler
set cmdheight=2
set hid
set hlsearch
set incsearch
set showmatch
set nowrap
set backspace=2
set backspace=indent,eol,start
set autochdir
set clipboard+=unnamed
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



colorscheme molo
set background=dark

syntax on
filetype plugin indent on

" Use with MouseTerm to scroll!
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

" function to toggle color column
function! ColorColumn()
  if empty(&colorcolumn)
    if empty(&textwidth)
      echo "colorcolumn=80"
      setlocal colorcolumn=80
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

" pydoc
map <Leader>pd :Pydoc 

" auto-reform ugly json
nmap <Leader>rj :%!python -mjson.tool<CR>

" easy resizing of wide windows
nmap + <C-W>+
nmap - <C-W>-

" Search mappings: These will make it so that going to the next one in a
" search will center on the line it's found in.
map N Nzz
map n nzz

" Set visual mode indent
:vnoremap < <gv
:vnoremap > >gv

" Allows for hashtag comments to be inserted on a visual block
" (at the beginning of the line) with a question mark
:vnoremap ? <ESC>:'<,'>s/^/# /g<cr> :noh<cr>

let g:SuperTabDefaultCompletionType="context"
set completeopt=menu,longest,preview
let g:SuperTabNoCompleteAfter=['^', '\s']

" remove auto string apostrophe concealing in json
let g:vim_json_syntax_conceal = 0

let g:pydoc_open_cmd = 'vsplit' 

let g:pep8_map='<F8>'

let NERDTreeIgnore = ['\.pyc$', '\.pyo$']
nmap <F5> :NERDTreeToggle<CR>

nmap <F6> :TagbarToggle<CR>

