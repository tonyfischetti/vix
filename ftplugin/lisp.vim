setlocal tabstop=2
setlocal softtabstop=2
setlocal shiftwidth=2

function! RestartLisp()
    :SlimeSend1 (quit)
    :SlimeSend1 sbcl
endfunction

" function! LoadFile()
"     let cmd = "(LOAD \"". bufname("%") . "\")"
"     :SlimeSend1 

function! HyperLookup(symbol)
    execute "!open \"http://l1sp.org/search?q=" . a:symbol . "\" &"
endfunction

command! -nargs=1 Apropos :SlimeSend1 (apropos "<args>")
command! -nargs=1 Describe :SlimeSend1 (describe '<args>)
command! -nargs=1 Documentation :SlimeSend1 (documentation '<args> 'function)
command! -nargs=1 Hyper :call HyperLookup("<args>")
command! -nargs=0 Out :SlimeSend1 0
command! -nargs=0 Restart :call RestartLisp()
command! -nargs=1 Load :SlimeSend1 (LOAD ">")


function! Dothis()
    execute "normal 
endfunction

nmap <C-C> va(<C-X><C-X>%j0

