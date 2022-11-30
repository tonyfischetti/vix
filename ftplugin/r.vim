setlocal tabstop=2
setlocal softtabstop=2
setlocal shiftwidth=2

command -nargs=0 RCopyLastValue :SlimeSend1 copy_last_value()

" run block in R
nmap <silent> <Leader>rr /^}v%0<C-Space>j<Leader>nh
