" Vim color file
" Maintainer: David Ne\v{c}as (Yeti) <yeti@physics.muni.cz>
" Last Change: 2001 May 21
" URI: http://physics.muni.cz/~yeti/download/peachpuff.vim

" This color scheme uses a peachpuff background (what you've expected when it's
" called peachpuff?).
"
" Note: Only GUI colors differ from default, on terminal it's just `light'.

" First remove all existing highlighting.
set background=light
hi clear
if exists("syntax_on")
  syntax reset
endif

let colors_name = "royi"

"@@@ hi Normal guibg=#fdfeed guifg=#131926
"hi Normal guibg=#f1eedf guifg=#131926

hi SpecialKey term=bold ctermfg=4 guifg=Blue
hi NonText term=bold cterm=bold ctermfg=4 gui=bold guifg=Blue
hi Directory term=bold ctermfg=4 guifg=Blue
hi ErrorMsg term=standout cterm=bold ctermfg=7 ctermbg=1 gui=bold guifg=White guibg=Red
hi IncSearch term=reverse cterm=reverse gui=reverse
"@@@hi Search term=reverse ctermbg=3 gui=underline guibg=#eeeeb0
hi Search term=standout ctermbg=3 gui=underline guibg=Yellow
"hi Search term=reverse ctermbg=3 gui=underline guibg=#e0dbc0
hi MoreMsg term=bold ctermfg=2 gui=bold guifg=SeaGreen
hi ModeMsg term=bold cterm=bold gui=bold
hi LineNr term=underline ctermfg=3 guifg=Red3
hi Question term=standout ctermfg=2 gui=bold guifg=SeaGreen
hi StatusLine term=bold,reverse cterm=bold,reverse gui=bold guifg=White guibg=Black
hi StatusLineNC term=reverse cterm=reverse gui=bold guifg=PeachPuff guibg=Gray45
hi VertSplit term=reverse cterm=reverse gui=bold guifg=White guibg=Gray45
hi Title term=bold ctermfg=5 gui=bold guifg=DeepPink3
hi Visual term=reverse cterm=reverse gui=reverse guifg=Grey80 guibg=fg
hi VisualNOS term=bold,underline cterm=bold,underline gui=bold,underline
hi WarningMsg term=standout ctermfg=1 gui=bold guifg=Red
hi WildMenu term=standout ctermfg=0 ctermbg=3 guifg=Black guibg=Yellow
"@@@ hi Folded term=standout ctermfg=4 ctermbg=7 guifg=Black guibg=#e3e0c5
hi Folded term=standout ctermfg=4 ctermbg=7 guifg=Black guibg=#d3d0b5
hi FoldColumn term=standout ctermfg=4 ctermbg=7 guifg=DarkBlue guibg=Gray80

"@@@ hi DiffAdd term=bold ctermbg=4 guibg=#d6ffb0
hi DiffAdd term=bold ctermbg=4 guibg=#d3edbb
"@@@ hi DiffChange term=bold ctermbg=5 guibg=#fef4df
hi DiffChange term=bold ctermbg=5 guibg=#efe5d0
hi DiffDelete term=bold cterm=bold ctermfg=4 ctermbg=6 gui=bold guifg=lightGray guibg=DarkGray
hi DiffText term=reverse cterm=bold ctermbg=1 gui=bold guibg=#e3c1a5

hi Cursor guifg=bg guibg=fg
hi lCursor guifg=bg guibg=fg

" Colors for syntax highlighting
hi Comment term=bold ctermfg=4 guifg=#406090
hi Constant term=underline ctermfg=1 guifg=#c00058
hi Special term=bold ctermfg=5 guifg=SeaGreen
hi Identifier guifg=Black
hi Statement term=bold ctermfg=3 guifg=Black
hi Function gui=bold ctermfg=3 guifg=Black
hi PreProc term=underline ctermfg=5 

if &diff
  hi Type gui=NONE guifg=Black
else
  hi Type gui=italic guifg=Black
endif

hi Ignore cterm=bold ctermfg=7 guifg=bg
"@@@ hi Error term=reverse cterm=bold ctermfg=7 ctermbg=1 gui=bold guifg=Red guibg=#fdfeed
hi Error term=reverse cterm=bold ctermfg=7 ctermbg=1 gui=bold guifg=Red guibg=#f1eedf
hi Todo term=standout ctermfg=0 ctermbg=3 guifg=Blue guibg=Yellow
hi cOperator gui=bold

hi cIf0 guifg=#406090
hi cIf0Delim guifg=#406090

hi cBoldOpen gui=bold guifg=#c00058
hi cBoldClose gui=bold guifg=#c00058

