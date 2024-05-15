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

set background=dark
hi clear
syntax reset

let g:colors_name = "lcars"

hi Bold   cterm=bold gui=bold
hi Boolean ctermfg=147 guifg=#afafff  cterm=bold gui=bold
hi Builtin ctermfg=147 guifg=#afafff  cterm=bold gui=bold
hi Character ctermfg=186 guifg=#e6db74  
hi ColorColumn  ctermbg=16 guibg=#232931 
hi Comment ctermfg=152 guifg=#afd7d7  
hi Conceal ctermfg=16 guifg=#080808  
hi Conditional ctermfg=176 guifg=#d787d7  cterm=bold gui=bold
hi Constant ctermfg=147 guifg=#afafff  cterm=bold gui=bold
hi Cursor ctermfg=233 guifg=#131a24 ctermbg=231 guibg=#f8f8f2 
hi CursorColumn  ctermbg=60 guibg=#666d7a 
hi CursorIM ctermfg=233 guifg=#131a24 ctermbg=231 guibg=#f8f8f2 
hi CursorLine  ctermbg=16 guibg=#232931 
hi CursorLineNr ctermfg=183 guifg=#deaded  
hi Debug ctermfg=116 guifg=#98dccf  cterm=bold gui=bold
hi Define ctermfg=222 guifg=#ffe587  cterm=bold gui=bold
hi Delimiter ctermfg=102 guifg=#808080  
hi DiffAdd  ctermbg=73 guibg=#5fafaf 
hi DiffChange  ctermbg=60 guibg=#565f89 
hi DiffDelete  ctermbg=168 guibg=#d75f87 
hi DiffText  ctermbg=73 guibg=#5fafaf cterm=bold,underline gui=bold,underline
hi Directory ctermfg=222 guifg=#ffe587  cterm=bold gui=bold
hi EndOfBuffer ctermfg=183 guifg=#deaded ctermbg=233 guibg=#131a24 
hi Error ctermfg=197 guifg=#f92672 ctermbg=16 guibg=#000000 cterm=bold gui=bold
hi ErrorMsg ctermfg=197 guifg=#f92672 ctermbg=16 guibg=#000000 cterm=bold gui=bold
hi Exception ctermfg=176 guifg=#d787d7  cterm=bold gui=bold
hi Float ctermfg=147 guifg=#afafff  cterm=bold gui=bold
hi FloatBorder ctermfg=104 guifg=#8787d7 ctermbg=16 guibg=#0b131d 
hi Floaterm  ctermbg=16 guibg=#0b131d 
hi FloatermBorder ctermfg=104 guifg=#8787d7 ctermbg=16 guibg=#0b131d 
hi FoldColumn ctermfg=60 guifg=#565f89 ctermbg=233 guibg=#131a24 
hi Folded ctermfg=30 guifg=#008787 ctermbg=60 guibg=#666d7a 
hi Function ctermfg=116 guifg=#98dccf  cterm=bold gui=bold
hi Identifier ctermfg=147 guifg=#afafff  
hi IncSearch ctermfg=204 guifg=#ff5f87 ctermbg=16 guibg=#000000 
hi Include ctermfg=204 guifg=#ff5f87  cterm=bold gui=bold
hi Keyword ctermfg=147 guifg=#afafff  cterm=bold gui=bold
hi Label ctermfg=152 guifg=#afd7d7  cterm=bold gui=bold
hi LineNr ctermfg=60 guifg=#666d7a  
hi LispBarSymbol ctermfg=104 guifg=#8787d7  
hi LispDecl ctermfg=204 guifg=#ff5f87  cterm=bold gui=bold
hi LispEscapeSpecial ctermfg=67 guifg=#5f87af  cterm=bold gui=bold
hi LispFunc ctermfg=147 guifg=#afafff  
hi LispKey ctermfg=104 guifg=#8787d7  
hi Macro ctermfg=222 guifg=#ffe587  cterm=bold gui=bold
hi MatchParen ctermfg=222 guifg=#ffe587  cterm=bold gui=bold
hi ModeMsg ctermfg=186 guifg=#e6db74  
hi MoreMsg ctermfg=152 guifg=#afd7d7  
hi MsgArea ctermfg=146 guifg=#afafd7  
hi MsgSeparator ctermfg=231 guifg=#f8f8f2 ctermbg=233 guibg=#131a24 
hi NonText ctermfg=16 guifg=#0b131d  
hi Normal ctermfg=231 guifg=#f8f8f2 ctermbg=233 guibg=#131a24 
hi NormalFloat ctermfg=231 guifg=#f8f8f2 ctermbg=16 guibg=#0b131d 
hi NormalNC ctermfg=231 guifg=#f8f8f2 ctermbg=233 guibg=#131a24 
hi NormalSB ctermfg=231 guifg=#f8f8f2 ctermbg=16 guibg=#0b131d 
hi Number ctermfg=147 guifg=#afafff  cterm=bold gui=bold
hi NvimTreeCursorLine  ctermbg=16 guibg=#232931 
hi NvimTreeEmptyFolderName ctermfg=152 guifg=#afd7d7  
hi NvimTreeEndOfBuffer ctermfg=16 guifg=#0b131d  
hi NvimTreeExecFile ctermfg=67 guifg=#5f87af  
hi NvimTreeFolderIcon ctermfg=222 guifg=#ffe587  cterm=bold gui=bold
hi NvimTreeFolderName ctermfg=152 guifg=#afd7d7  cterm=bold gui=bold
hi NvimTreeGitDeleted ctermfg=95 guifg=#875f5f  
hi NvimTreeGitDirty ctermfg=204 guifg=#ff5f87  
hi NvimTreeGitIgnored ctermfg=152 guifg=#afd7d7  
hi NvimTreeGitMerge ctermfg=67 guifg=#5f87af  
hi NvimTreeGitNew ctermfg=122 guifg=#87ffd7  
hi NvimTreeGitRenamed ctermfg=73 guifg=#5fafaf  
hi NvimTreeGitStaged ctermfg=73 guifg=#5fafaf  
hi NvimTreeImageFile ctermfg=146 guifg=#afafd7  
hi NvimTreeIndentMarker ctermfg=60 guifg=#666d7a  
hi NvimTreeNormal  ctermbg=16 guibg=#0b131d 
hi NvimTreeNormalNC ctermfg=146 guifg=#afafd7 ctermbg=16 guibg=#0b131d 
hi NvimTreeOpenedFile  ctermbg=60 guibg=#666d7a 
hi NvimTreeOpenedFolderName ctermfg=116 guifg=#98dccf  cterm=bold gui=bold
hi NvimTreeRootFolder ctermfg=73 guifg=#5fafaf  cterm=bold gui=bold
hi NvimTreeSpecialFile ctermfg=122 guifg=#87ffd7  cterm=underline gui=underline
hi NvimTreeSymlink ctermfg=16 guifg=#000000  
hi NvimTreeVertSplit ctermfg=146 guifg=#afafd7 ctermbg=146 guibg=#afafd7 
hi NvimTreeWinSeparator ctermfg=16 guifg=#0b131d ctermbg=16 guibg=#0b131d 
hi OLDIdentifier ctermfg=176 guifg=#d787d7  
hi OLDNumber ctermfg=147 guifg=#afafff  
hi OLDOperator ctermfg=204 guifg=#ff5f87  cterm=bold gui=bold
hi OLDType ctermfg=168 guifg=#d75f87  cterm=bold gui=bold
hi OLD_MatchParen ctermfg=204 guifg=#ff5f87  cterm=bold gui=bold
hi Operator ctermfg=204 guifg=#ff5f87  
hi Pmenu ctermfg=122 guifg=#87ffd7 ctermbg=16 guibg=#0b131d 
hi PmenuSbar  ctermbg=16 guibg=#0b131d 
hi PmenuSel ctermfg=16 guifg=#000000 ctermbg=204 guibg=#ff5f87 
hi PmenuThumb  ctermbg=60 guibg=#666d7a 
hi PreCondit ctermfg=147 guifg=#afafff  cterm=bold gui=bold
hi PreProc ctermfg=204 guifg=#ff5f87  cterm=bold gui=bold
hi Question ctermfg=116 guifg=#98dccf  
hi QuickFixLine  ctermbg=60 guibg=#666d7a cterm=bold gui=bold
hi Repeat ctermfg=204 guifg=#ff5f87  cterm=bold gui=bold
hi Search ctermfg=183 guifg=#deaded ctermbg=233 guibg=#131a24 
hi SignColumn ctermfg=231 guifg=#f8f8f2 ctermbg=233 guibg=#131a24 
hi SignColumnSB ctermfg=231 guifg=#f8f8f2 ctermbg=16 guibg=#0b131d 
hi Sneak ctermfg=16 guifg=#000000 ctermbg=204 guibg=#ff5f87 cterm=bold gui=bold
hi Special ctermfg=122 guifg=#87ffd7  cterm=bold gui=bold
hi SpecialChar ctermfg=122 guifg=#87ffd7  cterm=bold gui=bold
hi SpecialKey ctermfg=16 guifg=#131a24  cterm=bold gui=bold
hi Statement ctermfg=104 guifg=#8787d7  cterm=bold gui=bold
hi StatusLine ctermfg=166 guifg=#cd5907 ctermbg=188 guibg=#dadada 
hi StatusLineNC ctermfg=102 guifg=#808080 ctermbg=16 guibg=#080808 
hi StorageClass ctermfg=67 guifg=#5f87af  cterm=bold gui=bold
hi String ctermfg=222 guifg=#ffe587  cterm=bold gui=bold
hi Structure ctermfg=116 guifg=#98dccf  
hi Substitute ctermfg=16 guifg=#000000 ctermbg=210 guibg=#f7768e 
hi TODO ctermfg=176 guifg=#d787d7 ctermbg=233 guibg=#131a24 
hi TabLine ctermfg=60 guifg=#666d7a ctermbg=16 guibg=#080808 
hi TabLineFill  ctermbg=16 guibg=#000000 
hi TabLineSel ctermfg=16 guifg=#000000 ctermbg=30 guibg=#008787 
hi Tag ctermfg=147 guifg=#afafff  cterm=bold gui=bold
hi TelescopeBorder ctermfg=104 guifg=#8787d7 ctermbg=16 guibg=#0b131d 
hi TelescopeMatching ctermfg=122 guifg=#87ffd7  cterm=bold gui=bold
hi TelescopeNormal ctermfg=231 guifg=#f8f8f2 ctermbg=16 guibg=#0b131d 
hi TelescopePreviewHyphen ctermfg=210 guifg=#f7768e  
hi TelescopePreviewTitle ctermfg=204 guifg=#ff5f87  
hi TelescopePromptCounter ctermfg=210 guifg=#f7768e  
hi TelescopePromptPrefix ctermfg=204 guifg=#ff5f87  
hi TelescopePromptTitle ctermfg=204 guifg=#ff5f87  
hi TelescopeResultsTitle ctermfg=204 guifg=#ff5f87  
hi TelescopeSelection  ctermbg=60 guibg=#666d7a 
hi TelescopeSelectionCaret ctermfg=210 guifg=#f7768e ctermbg=60 guibg=#666d7a 
hi TermCursor ctermfg=233 guifg=#131a24 ctermbg=231 guibg=#f8f8f2 
hi TermCursorNC ctermfg=233 guifg=#131a24 ctermbg=231 guibg=#f8f8f2 
hi Title ctermfg=204 guifg=#ff5f87  cterm=bold gui=bold
hi Todo ctermfg=16 guifg=#000000 ctermbg=204 guibg=#ff5f87 cterm=bold gui=bold
hi Type ctermfg=204 guifg=#ff5f87  cterm=bold gui=bold
hi Typedef ctermfg=147 guifg=#afafff  
hi Underlined   cterm=underline gui=underline
hi Variable ctermfg=231 guifg=#f8f8f2  
hi VertSplit ctermfg=204 guifg=#ff5f87  cterm=bold gui=bold
hi Visual  ctermbg=60 guibg=#666d7a 
hi VisualNOS  ctermbg=60 guibg=#666d7a 
hi WarningMsg ctermfg=228 guifg=#ffff87  cterm=bold gui=bold
hi Whitespace ctermfg=60 guifg=#666d7a  
hi WildMenu  ctermbg=60 guibg=#666d7a cterm=bold gui=bold
hi WinSeparator ctermfg=168 guifg=#d75f87  cterm=bold gui=bold
hi cFormat ctermfg=152 guifg=#afd7d7  
hi cTypeDef ctermfg=147 guifg=#afafff  
hi cppExceptions ctermfg=122 guifg=#87ffd7  
hi cppInNamespace ctermfg=30 guifg=#008787  
hi cppSTLFunction ctermfg=122 guifg=#87ffd7  
hi cppSTLnamespace ctermfg=30 guifg=#008787  
hi darkDebug ctermfg=238 guifg=#444444  
hi gitcommitSummary ctermfg=204 guifg=#ff5f87  cterm=bold gui=bold
hi jsArrowFunction ctermfg=168 guifg=#d75f87  cterm=bold gui=bold
hi jsFuncCall ctermfg=104 guifg=#8787d7  cterm=bold gui=bold
hi jsGlobalObjects ctermfg=139 guifg=#af87af  cterm=bold gui=bold
hi jsObjectProp ctermfg=152 guifg=#afd7d7  cterm=bold gui=bold
hi lCursor ctermfg=233 guifg=#131a24 ctermbg=231 guibg=#f8f8f2 
hi lispComment ctermfg=122 guifg=#87ffd7  
hi makeCommands ctermfg=222 guifg=#ffe587  
hi makeComment ctermfg=146 guifg=#afafd7  
hi makeIdent ctermfg=116 guifg=#98dccf  
hi makeInclude ctermfg=210 guifg=#f7768e  cterm=bold gui=bold
hi makeSpecTarget ctermfg=210 guifg=#f7768e  cterm=bold gui=bold
hi makeSpecial ctermfg=210 guifg=#f7768e  cterm=bold gui=bold
hi makeStatement ctermfg=210 guifg=#f7768e  cterm=bold gui=bold
hi makeTarget ctermfg=147 guifg=#afafff  cterm=bold gui=bold
hi ps1Cmdlet ctermfg=204 guifg=#ff5f87  cterm=bold gui=bold
hi ps1InterpolationDelimiter ctermfg=204 guifg=#ff5f87  cterm=bold gui=bold
hi pythonBuiltin ctermfg=176 guifg=#d787d7  
hi pythonDecorator ctermfg=204 guifg=#ff5f87  
hi pythonParameters ctermfg=152 guifg=#afd7d7  
hi rArrow ctermfg=204 guifg=#ff5f87  cterm=bold gui=bold
hi rBoolean ctermfg=67 guifg=#5f87af  cterm=bold gui=bold
hi rConstant ctermfg=67 guifg=#5f87af  cterm=bold gui=bold
hi racketFunc ctermfg=176 guifg=#d787d7  
hi racketSyntax ctermfg=204 guifg=#ff5f87  cterm=bold gui=bold
hi typescriptBranch ctermfg=204 guifg=#ff5f87  cterm=bold gui=bold
hi typescriptReserved ctermfg=204 guifg=#ff5f87  cterm=bold gui=bold
hi zshCommands ctermfg=204 guifg=#ff5f87  cterm=bold gui=bold
