set background=light
highlight clear
if exists("syntax_on")
    syntax reset
    syntax off
endif
let g:colors_name = "plain"

hi Normal guifg=#CC0000 guibg=#FFFFc1 ctermfg=88 ctermbg=229 cterm=bold
