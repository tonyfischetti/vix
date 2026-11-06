setlocal tabstop=2
setlocal softtabstop=2
setlocal shiftwidth=2

" K on a symbol shows its signature and docstring in a floating window
" (lua/vix/lib/pluto-doc.lua), asked of the saved core by
" ~/.zsh/bin/pluto-doc -- no REPL needed. ':' is a keyword character
" in lisp buffers, so styx:md5/file works, too. K again focuses the
" window; moving the cursor closes it.
" (a buffer-local mapping rather than 'keywordprg': K is mapped
" globally to pretty_hover in plugins/hover.lua, which would win)
command! -buffer -nargs=1 PlutoDoc lua require('vix.lib.pluto-doc').show(<q-args>)
nnoremap <buffer> K <Cmd>lua require('vix.lib.pluto-doc').show(vim.fn.expand('<cword>'))<CR>

function! RestartLisp()
    :SlimeSend1 (quit)
    :SlimeSend1 sbcl
endfunction

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

" send the enclosing s-expression to slime, then move past it
nmap <buffer> <C-C> va(<C-Space>%j0
