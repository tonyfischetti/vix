" Vim color file - guardian
" Generated by http://bytefluent.com/vivify 2013-08-30
set background=dark
if version > 580
	hi clear
	if exists("syntax_on")
		syntax reset
	endif
endif

set t_Co=256
let g:colors_name = "guardian"

hi IncSearch guifg=#ffffff guibg=#0066cc guisp=#0066cc gui=NONE ctermfg=15 ctermbg=26 cterm=NONE
"hi WildMenu -- no settings --
"hi SignColumn -- no settings --
hi SpecialComment guifg=#dddddd guibg=#445566 guisp=#445566 gui=italic ctermfg=253 ctermbg=60 cterm=NONE
hi Typedef guifg=#99cc99 guibg=#221100 guisp=#221100 gui=italic ctermfg=151 ctermbg=52 cterm=NONE
hi Title guifg=#ffffff guibg=#445566 guisp=#445566 gui=bold ctermfg=15 ctermbg=60 cterm=bold
"hi Folded -- no settings --
hi PreCondit guifg=#99cc99 guibg=#221100 guisp=#221100 gui=bold ctermfg=151 ctermbg=52 cterm=bold
hi Include guifg=#99cc99 guibg=#221100 guisp=#221100 gui=bold ctermfg=151 ctermbg=52 cterm=bold
"hi TabLineSel -- no settings --
hi StatusLineNC guifg=#ffffff guibg=#cc4455 guisp=#cc4455 gui=NONE ctermfg=15 ctermbg=167 cterm=NONE
"hi CTagsMember -- no settings --
hi NonText guifg=#ffeecc guibg=#445566 guisp=#445566 gui=bold ctermfg=230 ctermbg=60 cterm=bold
"hi CTagsGlobalConstant -- no settings --
hi DiffText guifg=#ffffff guibg=#884444 guisp=#884444 gui=bold ctermfg=15 ctermbg=95 cterm=bold
hi ErrorMsg guifg=#ff0000 guibg=#221100 guisp=#221100 gui=bold ctermfg=196 ctermbg=52 cterm=bold
hi Ignore guifg=#cccccc guibg=#221100 guisp=#221100 gui=italic ctermfg=252 ctermbg=52 cterm=NONE
hi Debug guifg=#ff9999 guibg=#221100 guisp=#221100 gui=NONE ctermfg=210 ctermbg=52 cterm=NONE
hi PMenuSbar guifg=NONE guibg=#221100 guisp=#221100 gui=NONE ctermfg=NONE ctermbg=52 cterm=NONE
hi Identifier guifg=#ffddaa guibg=#221100 guisp=#221100 gui=bold ctermfg=223 ctermbg=52 cterm=bold
hi SpecialChar guifg=#bbddff guibg=#221100 guisp=#221100 gui=bold ctermfg=153 ctermbg=52 cterm=bold
hi Conditional guifg=#ff6666 guibg=#221100 guisp=#221100 gui=bold ctermfg=9 ctermbg=52 cterm=bold
hi StorageClass guifg=#99cc99 guibg=#221100 guisp=#221100 gui=bold ctermfg=151 ctermbg=52 cterm=bold
hi Todo guifg=#ff0000 guibg=#556677 guisp=#556677 gui=bold ctermfg=196 ctermbg=60 cterm=bold
hi Special guifg=#bbddff guibg=#221100 guisp=#221100 gui=bold ctermfg=153 ctermbg=52 cterm=bold
hi LineNr guifg=#aaaaaa guibg=#221100 guisp=#221100 gui=NONE ctermfg=248 ctermbg=52 cterm=NONE
hi StatusLine guifg=#000000 guibg=#ffeecc guisp=#ffeecc gui=bold ctermfg=NONE ctermbg=230 cterm=bold
hi Normal guifg=#ffffff guibg=#221100 guisp=#221100 gui=NONE ctermfg=15 ctermbg=52 cterm=NONE
hi Label guifg=#ffccff guibg=#221100 guisp=#221100 gui=bold ctermfg=225 ctermbg=52 cterm=bold
"hi CTagsImport -- no settings --
hi PMenuSel guifg=#000000 guibg=#ffeecc guisp=#ffeecc gui=NONE ctermfg=NONE ctermbg=230 cterm=NONE
"hi Search -- no settings --
"hi CTagsGlobalVariable -- no settings --
hi Delimiter guifg=#ffffff guibg=#221100 guisp=#221100 gui=NONE ctermfg=15 ctermbg=52 cterm=NONE
hi Statement guifg=#ffffcc guibg=#221100 guisp=#221100 gui=bold ctermfg=230 ctermbg=52 cterm=bold
"hi SpellRare -- no settings --
"hi EnumerationValue -- no settings --
hi Comment guifg=#dddddd guibg=#445566 guisp=#445566 gui=NONE ctermfg=253 ctermbg=60 cterm=NONE
hi Character guifg=#ffffcc guibg=#221100 guisp=#221100 gui=bold ctermfg=230 ctermbg=52 cterm=bold
hi Float guifg=#bbddff guibg=#221100 guisp=#221100 gui=bold ctermfg=153 ctermbg=52 cterm=bold
hi Number guifg=#bbddff guibg=#221100 guisp=#221100 gui=bold ctermfg=153 ctermbg=52 cterm=bold
hi Boolean guifg=#bbddff guibg=#221100 guisp=#221100 gui=NONE ctermfg=153 ctermbg=52 cterm=NONE
hi Operator guifg=#cc9966 guibg=#221100 guisp=#221100 gui=bold ctermfg=173 ctermbg=52 cterm=bold
"hi CursorLine -- no settings --
"hi Union -- no settings --
"hi TabLineFill -- no settings --
hi Question guifg=#ccffcc guibg=#221100 guisp=#221100 gui=bold ctermfg=194 ctermbg=52 cterm=bold
hi WarningMsg guifg=#ff0000 guibg=#221100 guisp=#221100 gui=bold ctermfg=196 ctermbg=52 cterm=bold
"hi VisualNOS -- no settings --
hi DiffDelete guifg=#ffffff guibg=#884444 guisp=#884444 gui=NONE ctermfg=15 ctermbg=95 cterm=NONE
hi ModeMsg guifg=#ffeecc guibg=#221100 guisp=#221100 gui=NONE ctermfg=230 ctermbg=52 cterm=NONE
"hi CursorColumn -- no settings --
hi Define guifg=#99cc99 guibg=#221100 guisp=#221100 gui=bold ctermfg=151 ctermbg=52 cterm=bold
hi Function guifg=#ffddaa guibg=#221100 guisp=#221100 gui=bold ctermfg=223 ctermbg=52 cterm=bold
"hi FoldColumn -- no settings --
hi PreProc guifg=#ffcc99 guibg=#221100 guisp=#221100 gui=bold ctermfg=223 ctermbg=52 cterm=bold
"hi EnumerationName -- no settings --
hi Visual guifg=#ffffff guibg=#557799 guisp=#557799 gui=NONE ctermfg=15 ctermbg=67 cterm=NONE
hi MoreMsg guifg=#ffeecc guibg=#221100 guisp=#221100 gui=NONE ctermfg=230 ctermbg=52 cterm=NONE
"hi SpellCap -- no settings --
hi VertSplit guifg=#ffffff guibg=#cc4455 guisp=#cc4455 gui=NONE ctermfg=15 ctermbg=167 cterm=NONE
hi Exception guifg=#66ffcc guibg=#221100 guisp=#221100 gui=bold ctermfg=86 ctermbg=52 cterm=bold
hi Keyword guifg=#66ffcc guibg=#221100 guisp=#221100 gui=bold ctermfg=86 ctermbg=52 cterm=bold
hi Type guifg=#ff7788 guibg=#221100 guisp=#221100 gui=bold ctermfg=210 ctermbg=52 cterm=bold
hi DiffChange guifg=#ffffff guibg=#558855 guisp=#558855 gui=NONE ctermfg=15 ctermbg=65 cterm=NONE
hi Cursor guifg=#ffffff guibg=#cc4455 guisp=#cc4455 gui=bold ctermfg=15 ctermbg=167 cterm=bold
"hi SpellLocal -- no settings --
hi Error guifg=#ffffff guibg=#ff0000 guisp=#ff0000 gui=bold ctermfg=15 ctermbg=196 cterm=bold
hi PMenu guifg=#ffffff guibg=#cc4455 guisp=#cc4455 gui=NONE ctermfg=15 ctermbg=167 cterm=NONE
hi SpecialKey guifg=#ffffff guibg=#221100 guisp=#221100 gui=NONE ctermfg=15 ctermbg=52 cterm=NONE
hi Constant guifg=#ffffff guibg=#221100 guisp=#221100 gui=bold ctermfg=15 ctermbg=52 cterm=bold
"hi DefinedName -- no settings --
hi Tag guifg=#bbddff guibg=#221100 guisp=#221100 gui=bold ctermfg=153 ctermbg=52 cterm=bold
hi String guifg=#ffffcc guibg=#221100 guisp=#221100 gui=italic ctermfg=230 ctermbg=52 cterm=NONE
hi PMenuThumb guifg=NONE guibg=#aaaaaa guisp=#aaaaaa gui=NONE ctermfg=NONE ctermbg=248 cterm=NONE
"hi MatchParen -- no settings --
"hi LocalVariable -- no settings --
hi Repeat guifg=#ff9900 guibg=#221100 guisp=#221100 gui=bold ctermfg=208 ctermbg=52 cterm=bold
"hi SpellBad -- no settings --
"hi CTagsClass -- no settings --
hi Directory guifg=#337700 guibg=#221100 guisp=#221100 gui=NONE ctermfg=2 ctermbg=52 cterm=NONE
hi Structure guifg=#99ff99 guibg=#221100 guisp=#221100 gui=bold ctermfg=120 ctermbg=52 cterm=bold
hi Macro guifg=#99cc99 guibg=#221100 guisp=#221100 gui=bold ctermfg=151 ctermbg=52 cterm=bold
hi Underlined guifg=#99ccff guibg=#221100 guisp=#221100 gui=underline ctermfg=153 ctermbg=52 cterm=underline
hi DiffAdd guifg=#ffffff guibg=#446688 guisp=#446688 gui=NONE ctermfg=15 ctermbg=60 cterm=NONE
"hi TabLine -- no settings --
hi cursorim guifg=#ffffff guibg=#e000b0 guisp=#e000b0 gui=NONE ctermfg=15 ctermbg=163 cterm=NONE
"hi clear -- no settings --
hi lcursor guifg=#ffffff guibg=#e000b0 guisp=#e000b0 gui=NONE ctermfg=15 ctermbg=163 cterm=NONE
"hi semicolon -- no settings --
hi titled guifg=#ffffff guibg=#221100 guisp=#221100 gui=NONE ctermfg=15 ctermbg=52 cterm=NONE
hi incsearch guifg=#ffffff guibg=#0066cc guisp=#0066cc gui=NONE ctermfg=15 ctermbg=26 cterm=NONE
hi htmlh2 guifg=#ffffff guibg=#221100 guisp=#221100 gui=bold ctermfg=15 ctermbg=52 cterm=bold
hi cursor guifg=#ffffff guibg=#cc4455 guisp=#cc4455 gui=bold ctermfg=15 ctermbg=167 cterm=bold
