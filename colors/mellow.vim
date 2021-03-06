" Vim color file - mellow
" Generated by http://bytefluent.com/vivify 2013-08-30
set background=light
if version > 580
	hi clear
	if exists("syntax_on")
		syntax reset
	endif
endif

set t_Co=256
let g:colors_name = "mellow"

hi IncSearch guifg=NONE guibg=#CC6600 guisp=#CC6600 gui=NONE ctermfg=NONE ctermbg=166 cterm=NONE
"hi WildMenu -- no settings --
"hi SignColumn -- no settings --
"hi SpecialComment -- no settings --
hi Typedef guifg=#c000c8 guibg=NONE guisp=NONE gui=NONE ctermfg=5 ctermbg=NONE cterm=NONE
hi Title guifg=#000000 guibg=#ffffff guisp=#ffffff gui=NONE ctermfg=NONE ctermbg=15 cterm=NONE
"hi Folded -- no settings --
hi PreCondit guifg=#808040 guibg=NONE guisp=NONE gui=NONE ctermfg=101 ctermbg=NONE cterm=NONE
hi Include guifg=#808040 guibg=NONE guisp=NONE gui=NONE ctermfg=101 ctermbg=NONE cterm=NONE
"hi TabLineSel -- no settings --
"hi StatusLineNC -- no settings --
"hi CTagsMember -- no settings --
"hi NonText -- no settings --
"hi CTagsGlobalConstant -- no settings --
"hi DiffText -- no settings --
"hi ErrorMsg -- no settings --
"hi Ignore -- no settings --
"hi Debug -- no settings --
hi PMenuSbar guifg=NONE guibg=#666600 guisp=#666600 gui=NONE ctermfg=NONE ctermbg=58 cterm=NONE
hi Identifier guifg=#663333 guibg=NONE guisp=NONE gui=NONE ctermfg=95 ctermbg=NONE cterm=NONE
"hi SpecialChar -- no settings --
hi Conditional guifg=#0000c8 guibg=NONE guisp=NONE gui=NONE ctermfg=4 ctermbg=NONE cterm=NONE
hi StorageClass guifg=#0000c8 guibg=NONE guisp=NONE gui=NONE ctermfg=4 ctermbg=NONE cterm=NONE
"hi Todo -- no settings --
"hi Special -- no settings --
hi LineNr guifg=#ffffff guibg=#666600 guisp=#666600 gui=NONE ctermfg=15 ctermbg=58 cterm=NONE
"hi StatusLine -- no settings --
hi Normal guifg=#000000 guibg=#FFFFCC guisp=#FFFFCC gui=NONE ctermfg=NONE ctermbg=230 cterm=NONE
hi Label guifg=#0000c8 guibg=NONE guisp=NONE gui=NONE ctermfg=4 ctermbg=NONE cterm=NONE
"hi CTagsImport -- no settings --
hi PMenuSel guifg=#88dd88 guibg=#949698 guisp=#949698 gui=NONE ctermfg=114 ctermbg=246 cterm=NONE
hi Search guifg=#FFFF00 guibg=#336600 guisp=#336600 gui=NONE ctermfg=11 ctermbg=22 cterm=NONE
"hi CTagsGlobalVariable -- no settings --
"hi Delimiter -- no settings --
hi Statement guifg=#cc0000 guibg=NONE guisp=NONE gui=NONE ctermfg=160 ctermbg=NONE cterm=NONE
"hi SpellRare -- no settings --
"hi EnumerationValue -- no settings --
hi Comment guifg=#996600 guibg=NONE guisp=NONE gui=NONE ctermfg=94 ctermbg=NONE cterm=NONE
hi Character guifg=#888080 guibg=NONE guisp=NONE gui=NONE ctermfg=102 ctermbg=NONE cterm=NONE
hi Float guifg=#808880 guibg=NONE guisp=NONE gui=NONE ctermfg=65 ctermbg=NONE cterm=NONE
hi Number guifg=#808880 guibg=NONE guisp=NONE gui=NONE ctermfg=65 ctermbg=NONE cterm=NONE
hi Boolean guifg=#0000aa guibg=NONE guisp=NONE gui=NONE ctermfg=19 ctermbg=NONE cterm=NONE
"hi Operator -- no settings --
"hi CursorLine -- no settings --
"hi Union -- no settings --
"hi TabLineFill -- no settings --
"hi Question -- no settings --
"hi WarningMsg -- no settings --
"hi VisualNOS -- no settings --
"hi DiffDelete -- no settings --
"hi ModeMsg -- no settings --
"hi CursorColumn -- no settings --
hi Define guifg=#808040 guibg=NONE guisp=NONE gui=NONE ctermfg=101 ctermbg=NONE cterm=NONE
hi Function guifg=#660000 guibg=#ffffcc guisp=#ffffcc gui=NONE ctermfg=52 ctermbg=230 cterm=NONE
"hi FoldColumn -- no settings --
hi PreProc guifg=#808040 guibg=NONE guisp=NONE gui=NONE ctermfg=101 ctermbg=NONE cterm=NONE
"hi EnumerationName -- no settings --
"hi Visual -- no settings --
"hi MoreMsg -- no settings --
"hi SpellCap -- no settings --
"hi VertSplit -- no settings --
hi Exception guifg=#0000c8 guibg=NONE guisp=NONE gui=NONE ctermfg=4 ctermbg=NONE cterm=NONE
hi Keyword guifg=#008088 guibg=NONE guisp=NONE gui=NONE ctermfg=30 ctermbg=NONE cterm=NONE
hi Type guifg=#0000c8 guibg=NONE guisp=NONE gui=NONE ctermfg=4 ctermbg=NONE cterm=NONE
"hi DiffChange -- no settings --
hi Cursor guifg=#ffffff guibg=#ff0000 guisp=#ff0000 gui=NONE ctermfg=15 ctermbg=196 cterm=NONE
"hi SpellLocal -- no settings --
"hi Error -- no settings --
hi PMenu guifg=#dddddd guibg=#545658 guisp=#545658 gui=NONE ctermfg=253 ctermbg=240 cterm=NONE
"hi SpecialKey -- no settings --
hi Constant guifg=#888080 guibg=NONE guisp=NONE gui=NONE ctermfg=102 ctermbg=NONE cterm=NONE
"hi DefinedName -- no settings --
"hi Tag -- no settings --
hi String guifg=#006666 guibg=NONE guisp=NONE gui=NONE ctermfg=23 ctermbg=NONE cterm=NONE
hi PMenuThumb guifg=NONE guibg=#ffffff guisp=#ffffff gui=NONE ctermfg=NONE ctermbg=15 cterm=NONE
"hi MatchParen -- no settings --
"hi LocalVariable -- no settings --
hi Repeat guifg=#0000c8 guibg=NONE guisp=NONE gui=NONE ctermfg=4 ctermbg=NONE cterm=NONE
"hi SpellBad -- no settings --
"hi CTagsClass -- no settings --
"hi Directory -- no settings --
hi Structure guifg=#0000c8 guibg=NONE guisp=NONE gui=NONE ctermfg=4 ctermbg=NONE cterm=NONE
hi Macro guifg=#808040 guibg=NONE guisp=NONE gui=NONE ctermfg=101 ctermbg=NONE cterm=NONE
"hi Underlined -- no settings --
"hi DiffAdd -- no settings --
"hi TabLine -- no settings --
hi cursorim guifg=#6699CC guibg=#99CCCC guisp=#99CCCC gui=NONE ctermfg=68 ctermbg=152 cterm=NONE
"hi clear -- no settings --
hi lcursor guifg=NONE guibg=#00ffff guisp=#00ffff gui=NONE ctermfg=NONE ctermbg=14 cterm=NONE
"hi semicolon -- no settings --
hi titled guifg=#ffffff guibg=#221100 guisp=#221100 gui=NONE ctermfg=15 ctermbg=52 cterm=NONE
hi incsearch guifg=#ffffff guibg=#0066cc guisp=#0066cc gui=NONE ctermfg=15 ctermbg=26 cterm=NONE
hi htmlh2 guifg=#ffffff guibg=#221100 guisp=#221100 gui=bold ctermfg=15 ctermbg=52 cterm=bold
hi cursor guifg=#ffffff guibg=#cc4455 guisp=#cc4455 gui=bold ctermfg=15 ctermbg=167 cterm=bold
hi browsedirectory guifg=#FFFF00 guibg=NONE guisp=NONE gui=NONE ctermfg=11 ctermbg=NONE cterm=NONE
