setlocal tabstop=2
setlocal softtabstop=2
setlocal shiftwidth=2
setlocal smarttab
setlocal expandtab

function! RestartLisp()
    :SlimeSend1 (quit)
    :SlimeSend1 sbcl
endfunction

command -nargs=1 Apropos :SlimeSend1 (apropos "<args>")
command -nargs=1 Describe :SlimeSend1 (describe '<args>)
command -nargs=1 Documentation :SlimeSend1 (documentation '<args> 'function)
command -nargs=0 Restart :call RestartLisp()


function! Dothis()
    execute "normal 
endfunction

nmap <C-C> va(<C-X><C-X>%j0


