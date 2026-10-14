
function! HLNext()
    highlight BlackOnWhite ctermfg=black ctermbg=white
    " one match per window: clear the previous one so they don't pile up
    if exists('w:hlnext_id')
        silent! call matchdelete(w:hlnext_id)
    endif
    let target_pat = '\c\%#'.@/
    let w:hlnext_id = matchadd('BlackOnWhite', target_pat, 101)
    redraw
endfunction


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
endfunction

" this gets around the problem where sending large
" selections messes up the R REPL
function! SlimeMultiLine()
    :call SlimeOneLine()
    ":sleep 10m
endfunction

nmap <silent> <C-Space> :call SlimeOneLine()<CR>
" vmap <silent> <C-Space> :call SlimeMultiLine()<CR>
vmap <silent> <C-Space>  <Plug>SlimeRegionSend
nmap <silent> <C-O> <Plug>SlimeLineSend
nmap <silent> <C-L> :SlimeSend1 <CR>
imap <silent> <C-Space> <Esc>:call SlimeOneLineSamePlace()<CR>a


nmap <silent> <Leader>hg :echo "hi<" . synIDattr(synID(line("."),col("."),1),"name") . '> trans<'
\ . synIDattr(synID(line("."),col("."),0),"name") . "> lo<"
\ . synIDattr(synIDtrans(synID(line("."),col("."),1)),"name") . ">"<CR>

" let g:mucomplete#user_mappings = { 'snipmate' : "\<C-J>" }

