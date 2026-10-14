setlocal tabstop=2
setlocal softtabstop=2
setlocal shiftwidth=2

command -nargs=0 RCopyLastValue :SlimeSend1 copy_last_value()

" RStudio-style "run statement": <C-Space> sends the whole expression
" around the cursor (function/if/for block, multi-line call, pipeline)
" and steps past it. see r_statement_range in lua/vix/lib/slime-utils.lua
nnoremap <buffer> <silent> <C-Space> <Cmd>lua require('vix.lib.slime-utils').send_statement()<CR>
