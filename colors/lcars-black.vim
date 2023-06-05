" Vim color file - lcars
" Designed by Tony Fischetti <tony.fischetti@gmail.com>
"                                                                           "
"           ___       ___           ___           ___           ___         "
"          /\__\     /\  \         /\  \         /\  \         /\  \        "
"         /:/  /    /::\  \       /::\  \       /::\  \       /::\  \       "
"        /:/  /    /:/\:\  \     /:/\:\  \     /:/\:\  \     /:/\ \  \      "
"       /:/  /    /:/  \:\  \   /::\~\:\  \   /::\~\:\  \   _\:\~\ \  \     "
"      /:/__/    /:/__/ \:\__\ /:/\:\ \:\__\ /:/\:\ \:\__\ /\ \:\ \ \__\    "
"      \:\  \    \:\  \  \/__/ \/__\:\/:/  / \/_|::\/:/  / \:\ \:\ \/__/    "
"       \:\  \    \:\  \            \::/  /     |:|::/  /   \:\ \:\__\      "
"        \:\  \    \:\  \           /:/  /      |:|\/__/     \:\/:/  /      "
"         \:\__\    \:\__\         /:/  /       |:|  |        \::/  /       "
"          \/__/     \/__/         \/__/         \|__|         \/__/        "
"                                                                           "

hi clear

set background=dark

set t_Co=256
let g:colors_name = "lcars"


" hi Normal             ctermfg=254 guifg=#F8F8F2 ctermbg=233 guibg=#121212
hi Normal             ctermfg=254 guifg=#F8F8F2 ctermbg=233 guibg=#000000
hi Type               ctermfg=122 guifg=#87ffd7
hi Comment            ctermfg=122 guifg=#87ffd7
hi String             ctermfg=228 guifg=#ffff87
hi Boolean            ctermfg=135 guifg=#AE81FF
hi Character          ctermfg=144 guifg=#E6DB74
hi Number             ctermfg=104 guifg=#AE81FF
hi Conditional        ctermfg=176 guifg=#D787D7                           cterm=bold gui=bold
hi Constant           ctermfg=147 guifg=#AE81FF                           cterm=bold gui=bold
hi Cursor             ctermfg=16  guifg=#000000 ctermbg=253 guibg=#F35FBC
hi Debug              ctermfg=225 guifg=#BCA3A3                           cterm=bold gui=bold 
hi Define             ctermfg=81  guifg=#66D9EF
hi Delimiter          ctermfg=241 guifg=#8F8F8F
hi Builtin            ctermfg=135 guifg=#AE81FF                           cterm=bold gui=bold 
hi EasyMotionTarget   ctermfg=11  guifg=#E4E500                           gui=bold
hi EasyMotionShade    ctermfg=8   guifg=#444444                           guibg=bg gui=bold "!!!
hi DiffAdd                                      ctermbg=24  guibg=#0F1D0B
hi DiffChange         ctermfg=181 guifg=#89807D ctermbg=239 guibg=#322F2D
hi DiffDelete         ctermfg=162 guifg=#960050 ctermbg=53  guibg=#1E0010
hi DiffText                                     ctermbg=102 guibg=#4A4340 cterm=bold,italic gui=bold,italic
hi Directory          ctermfg=118 guifg=#A6E22E                           cterm=bold gui=bold
hi Error              ctermfg=219 guifg=#960050 ctermbg=89  guibg=#1E0010
hi ErrorMsg           ctermfg=199 guifg=#F92672 ctermbg=16  guibg=#232526 cterm=bold gui=bold
hi Exception          ctermfg=118 guifg=#A6E22E                           cterm=bold gui=bold
hi Float              ctermfg=135 guifg=#AE81FF
hi FoldColumn         ctermfg=67  guifg=#AAAAAA ctermbg=233
hi Folded             ctermfg=67  guifg=#666666 ctermbg=233
hi Identifier         ctermfg=176 guifg=#D787D7
hi Ignore             ctermfg=244 guifg=#808080 ctermbg=232
hi IncSearch          ctermfg=193 guibg=#000000 ctermbg=16  guifg=#FF8D00
hi Search             ctermfg=194 guifg=#000000 ctermbg=124 guibg=#E4E500
hi Keyword            ctermfg=167 guifg=#D75f5F                           cterm=bold gui=bold
hi Label              ctermfg=229 guifg=#E6DB74                           cterm=none gui=none
hi Macro              ctermfg=193 guifg=#C4BE89                           cterm=italic gui=italic
hi MatchParen         ctermfg=16  guifg=#E4E400 ctermbg=208 guibg=#434748 cterm=bold gui=bold
hi ModeMsg            ctermfg=229 guifg=#E6DB74
hi Pmenu              ctermfg=81  guifg=#cccccc ctermbg=16  guibg=#232728
hi PmenuSel                       guifg=#000000 ctermbg=244 guibg=#AAF412
hi PmenuSbar                                    ctermbg=232 guibg=#131414
hi PmenuThumb         ctermfg=81  guifg=#777777
hi PreCondit          ctermfg=118 guifg=#A6E22E                           cterm=bold gui=bold
hi Question           ctermfg=81  guifg=#66D9EF
hi SignColumn         ctermfg=100 guifg=#A6E22E ctermbg=235 guibg=#151617 cterm=underline
hi Special            ctermfg=122 guifg=#87FFD7                           cterm=bold gui=italic
hi SpecialChar        ctermfg=161 guifg=#F92672                           cterm=bold gui=bold
hi SpecialChar        ctermfg=122 guifg=#87FFD7                           cterm=bold gui=italic
hi SpecialComment     ctermfg=245 guifg=#465457                           cterm=bold gui=bold
hi SpecialKey         ctermfg=100 guifg=#444444                           cterm=underline gui=bold
hi Statement          ctermfg=104 guifg=#8787D7                           cterm=bold gui=bold 
hi StatusLine         ctermfg=238 guifg=#CD5907 ctermbg=253 guibg=#DADADA
hi StatusLineNC       ctermfg=244 guifg=#808080 ctermbg=232 guibg=#080808
hi Structure          ctermfg=81  guifg=#66D9EF
hi Tag                ctermfg=161 guifg=#F92672                           cterm=bold gui=italic
hi Title              ctermfg=168 guifg=#ef5939                           cterm=bold gui=bold
hi Todo               ctermfg=231 guifg=#FFFFFF ctermbg=232 guibg=#080808 cterm=bold gui=bold
hi Typedef            ctermfg=81  guifg=#66D9EF
hi Underlined         ctermfg=244 guifg=#808080                           cterm=underline gui=underline
hi VertSplit          ctermfg=244 guifg=#AAAAAA ctermbg=232 guibg=#080808 cterm=bold gui=bold
hi VisualNOS                                    ctermbg=238 guibg=#403D3D
hi Visual                                       ctermbg=239 guibg=#403D3D
hi WarningMsg         ctermfg=231 guifg=#FFFFFF ctermbg=238 guibg=#333333 cterm=bold gui=bold
hi WildMenu           ctermfg=81  guifg=#66D9EF ctermbg=16 guibg=#000000
hi CursorLine                                   ctermbg=234 guibg=#232728 cterm=none
hi CursorColumn                                 ctermbg=234 guibg=#1C1C1C
hi ColorColumn                                  ctermbg=234 guibg=#1C1C1C
hi LineNr             ctermfg=250 guifg=#AAAAAA ctermbg=233 guibg=#121212
hi NonText            ctermfg=240 guifg=#444444 ctermbg=233 guibg=#121212
hi htmlItalic         ctermfg=254 guifg=#E4E4E4 ctermbg=232 guibg=#080808
hi PreProc            ctermfg=204 guifg=#ff5f87                           cterm=bold gui=bold
hi Function           ctermfg=122 guifg=#87ffd7
hi Operator           ctermfg=204 guifg=#ff5f87
hi StorageClass       ctermfg=167 guifg=#D75f5F                           cterm=bold gui=bold
hi InheritUnderlined  ctermfg=118 guifg=#87FF00                           cterm=underline gui=underline

hi rComment           ctermfg=147 guifg=#AFAFFF
hi rArrow             ctermfg=167 guifg=#D75F7F
hi rPreProc           ctermfg=204 guifg=#ff5f87                           cterm=bold gui=bold

hi lispDecl           ctermfg=204 guifg=#ff5f87                           cterm=bold gui=bold
hi lispFunc           ctermfg=176 guifg=#D787D7
hi lispBarSymbol      ctermfg=176 guifg=#D787D7
hi lispKey            ctermfg=147 guifg=#AFAFFF
hi lispEscapeSpecial  ctermfg=147 guifg=#AFAFFF                           cterm=bold gui=bold

hi pythonRepeat       ctermfg=161 guifg=#F92672                           cterm=bold gui=bold
hi pythonConditional  ctermfg=176 guifg=#D787D7                           cterm=bold gui=bold
hi pythonException    ctermfg=176 guifg=#D787D7                           cterm=bold gui=bold
hi pythonBuiltin      ctermfg=176 guifg=#D787D7
hi pythonStatement    ctermfg=104 guifg=#8787D7                           cterm=bold gui=bold 
hi pythonRepeat       ctermfg=204 guifg=#ff5f87                           cterm=bold gui=bold
hi pythonConstant     ctermfg=167 guifg=#D75F5F                           cterm=bold gui=bold
hi pythonParameters   ctermfg=152 guifg=#AFD7D7
hi pythonComment      ctermfg=152 guifg=#AFD7D7

hi cType              ctermfg=168 guifg=#D75F87                           cterm=bold gui=bold
hi cFormat            ctermfg=152 guifg=#AFD7D7
hi cLabel             ctermfg=152 guifg=#AFD7D7
hi cCharacter         ctermfg=216 guifg=#FFAF87
hi cDefine            ctermfg=228 guifg=#ffff87                           cterm=bold gui=bold
hi cComment           ctermfg=152 guifg=#AFD7D7
hi cPreCondit         ctermfg=147 guifg=#AFAFFF                           cterm=bold gui=bold
hi cTypeDef           ctermfg=147 guifg=#AFAFFF

hi cppExceptions      ctermfg=122 guifg=#87ffd7

hi racketSyntax       ctermfg=204 guifg=#ff5f87                           cterm=bold gui=bold
hi racketFunc         ctermfg=176 guifg=#D787D7

hi makeCommands       ctermfg=147 guifg=#AFAFFF
hi gitcommitSummary   ctermfg=204 guifg=#ff5f87                           cterm=bold gui=bold
hi shOption           ctermfg=139 guifg=#AF87AF
hi zshCommands        ctermfg=204 guifg=#ff5f87                           cterm=bold gui=bold
hi shStatement        ctermfg=204 guifg=#ff5f87                           cterm=bold gui=bold

hi jsConditional      ctermfg=167 guifg=#D75F5F                           cterm=bold gui=bold
hi jsGlobalObjects    ctermfg=139 guifg=#AF87AF                           cterm=bold gui=bold
hi jsFuncCall         ctermfg=104 guifg=#8787D7                           cterm=bold gui=bold
hi jsObjectProp       ctermfg=152 guifg=#AFD7D7                           cterm=bold gui=bold
hi jsArrowFunction    ctermfg=168 guifg=#D75F87                           cterm=bold gui=bold
hi jsStorageClass     ctermfg=168 guifg=#D75F87                           cterm=bold gui=bold
hi jsComment          ctermfg=152 guifg=#AFD7D7
hi typescriptReserved ctermfg=204 guifg=#ff5f87                           cterm=bold gui=bold
hi typescriptBranch   ctermfg=204 guifg=#ff5f87                           cterm=bold gui=bold

hi ps1Keyword         ctermfg=147 guifg=#AFAFFF                           cterm=bold gui=bold
hi ps1Cmdlet          ctermfg=204 guifg=#ff5f87                           cterm=bold gui=bold
hi ps1Label           ctermfg=152 guifg=#AFD7D7

hi jsTemplateExpression       ctermfg=139 guifg=#AF87AF
hi ps1InterpolationDelimiter  ctermfg=168 guifg=#EF5939                   cterm=bold gui=bold

hi darkDebug ctermfg=238 guifg=#444444
