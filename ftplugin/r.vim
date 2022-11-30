setlocal tabstop=2
setlocal softtabstop=2
setlocal shiftwidth=2

command -nargs=0 RCopyLastValue :SlimeSend1 copy_last_value()

" select block in R
" nmap <silent> <Leader>bb /^}\v%0
" run block in R
nmap <silent> <Leader>rr /^}v%0<C-Space>j<Leader>nh
