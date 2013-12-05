execute pathogen#infect()


set guifont=Monaco\ for\ Powerline:h12
set guioptions-=L
set guioptions-=r
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
let os = substitute(system('uname'), "\n", "", "")
if os == "Darwin"
    set clipboard+=unnamed
else
    set clipboard=unnamedplus
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
set transparency=2







colorscheme molokai
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

" REDUNDANT from vimrc (commenting out)
" I make mistake sometimes
":command WQ wq
":command Wq wq
":command W w
":command Q q

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

" easy resizing of windows
" resize height
nmap + <C-W>+
nmap _ <C-W>-
" resize width
nmap = <C-W>>
nmap - <C-W><

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

" airline overrides
let g:airline_powerline_fonts = 1

let g:pydoc_open_cmd = 'vsplit'

let g:pep8_map='<Leader>p8'

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
    call ColorColumn()
    colorscheme plain
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

" Conque Term things
let g:ConqueTerm_ReadUnfocused = 1
let g:ConqueTerm_InsertOnEnter = 1
let g:ConqueTerm_CloseOnEnd = 1
nmap <silent> <Leader>vz :ConqueTermVSplit zsh<CR>
nmap <silent> <Leader>hz :ConqueTermSplit zsh<CR>
