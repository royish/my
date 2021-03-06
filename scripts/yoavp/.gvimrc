colorscheme yella

" ruins columns
runtime ftplugin/man.vim
map K \K

"
" settings
"
syntax enable
set bs=2 ai ru " for cygwin
set go-=T go-=a
set lines=32 columns=80 tw=80 pvh=14
set ic scs is vb sc sm mat=3 so=5
set scr=3 sw=2 sbr=\ \ �
"lsp=2
set sft " i want it?
set tags=tags;/,pkg/tags,os/linux-2.6/tags
set viminfo='120,\"50,h
set nohid ul=200
set path=.,include;/,.;/,/usr/include,
"set rulerformat=%22(%-19(%02B\ \ \ \ %l,%c%V%)%P%)

" jump to last place in the file
au BufReadPost * 
  \ if line("'\"") > 0 && line("'\"") <= line("$") | exe "normal g'\"" | endif


" avoid mistaken changes in soon-to-be-deleted files
" a better way to do this?
au BufNewFile,BufRead *.*.tmp setlocal noma

" for these file-type-commands to work you also need to change
" /usr/share/vim/[vim60]/filetype.vim
au BufNewFile,BufRead *.c.*.tmp setf c
au BufNewFile,BufRead *.h.*.tmp setf c
au BufNewFile,BufRead *.mak.*.tmp setf make
au BufNewFile,BufRead Makefile.*.tmp setf make
au BufNewFile,BufRead *.lang.*.tmp setf jlang
set guicursor=n-v-c:block-Cursor/lCursor-blinkwait528-blinkoff0-blinkon1144,ve:ver35-Cursor,o:hor50-Cursor,i-ci:ver25-Cursor/lCursor-blinkwait528-blinkoff0-blinkon1144,r-cr:hor20-Cursor/lCursor,sm:block-Cursor
set bk bdir=~/.vimbak dir=~/.vimbak
au BufEnter *.mib :syn sync fromstart

au BufRead *.c,*.h
    \ if expand("%:p:h") =~ 'asterisk' && expand("%:p:h") !~ 'jasterisk'
    \|    set ts=4
    \| endif

"
" maps
"
nmap <silent> g] g<c-]>
nmap <silent> <c-s> :w<cr>
nmap <silent> <c-q> :q<cr>
nmap <s-ins> "*p
nmap <c-s-ins> "+p
"@@@ ugly - find a better way?
" the problem is when pasting into a new line - i don't want the auto indent to
" be gone
" @@@@@@@@@@@@@@@@@@@@@@@@@@ P is bad for s-ins at end of line, p is bad in
" midline
imap <s-ins> z<bs><c-o>"*P
"imap <s-ins> <middlemouse>
"imap <c-s-ins> <c-o>"*p
imap <c-s-ins> z<bs><c-o>"+P
cmap <s-ins> <MiddleMouse>
cmap <c-s-ins> <MiddleMouse>
vnoremap y "*y
nmap Y y$
nmap <a-v> v$h
nmap <a-w> vE
nmap /// g??
imap /// <esc>///
map <silent> <s-right> <c-pagedown>
map <silent> <s-left> <c-pageup>

map  <silent> <a-right> 4zl
imap <silent> <a-right> <c-o>4zl
map  <silent> <a-l> <a-right>
imap <silent> <a-l> <a-right>

map <silent> <a-left> 4zh
imap <silent> <a-left> <c-o>4zh
map  <silent> <a-h> <a-left>
imap <silent> <a-h> <a-left>

map <silent> <a-down> 3<c-e>
imap <silent> <a-down> <c-o>3<c-e>
map  <silent> <a-j> <a-down>
imap <silent> <a-j> <a-down>

map <silent> <a-up> 3<c-y>
imap <silent> <a-up> <c-o>3<c-y>
map  <silent> <a-k> <a-up>
imap <silent> <a-k> <a-up>

map  <silent> <c-a-k> gk
imap  <silent> <c-a-k> <c-o>gk
map  <silent> <c-a-j> gj
imap  <silent> <c-a-j> <c-o>gj

map <silent> <c-down> <c-e>
map <silent> <c-j> <c-e>
map <silent> <c-up> <c-y>
map <silent> <c-k> <c-y>

imap <c-h> <left>
cmap <c-h> <left>
imap <c-j> <down>
imap <c-k> <up>
imap <c-l> <right>
cmap <c-l> <right>
imap <c-b> <bs>
cmap <c-b> <bs>
imap <c-s> <c-o><c-s>

map <silent> <s-f9> :%s/\r//g<cr>
"map <silent> <f8> :set hls!<cr>
"imap <silent> <f8> <esc>:set hls!<cr>a
"map <silent> <s-f8> :set ic!<cr>
map <silent> <s-f5> :set nows<cr>/^{<cr>zf%:set ws<cr>
"map <silent> <s-f11> :set fdm=indent<cr>:set fdm=manual<cr>
map <silent> <f6> :set wrap!<cr>
map <silent> <s-f6> :set tw=0<cr>

"imap <t_%9> <bs>
"cmap <t_%9> <bs>
inoremap '[ <c-o>_
noremap '[ _
inoremap '] <end>
noremap '] <end>
map <a-m> 0gm
imap <a-m> <esc>0gma
map <a-,> 0g$F,
imap <a-,> <esc>0g$F,a
map <a-.> 0g$
imap <a-.> <esc>0g$a
map <a-/> <c-o>_
imap <a-/> <c-o>_
map <a-;> 0g$F;
"imap <a-;> <esc>0g$F;a
map <a-s-;> :setf f<cr>
inoremap '/ _
cnoremap '/ _
omap p ib
vmap p ib
omap P ab
vmap P ab
omap s iB
vmap s iB
omap S aB
vmap S aB

map <silent> <c-space> :Tlist<cr>
imap <silent> <c-space> <c-x><c-o>
imap <silent> <a-space> <space>
nmap <silent> <a-n> :silent noh<CR>

cmap <c-a> <c-r><c-a>
cmap <c-w> <c-r><c-w>
cmap <c-/> <c-r><c-/>
imap <c-f> <c-x><c-f>
imap <a-l> <c-x><c-l>
imap <c-]> <c-x><c-]>

  " preview
map <silent> <c-a-o> :ped ~/scripts/oporder.txt<cr>
imap <silent> <c-a-o> <c-o><c-a-o>
"map <silent> <a-[> <c-w>z
map <silent> <a-[> <c-w>o
imap <silent> <a-[> <c-o><c-w>o
"@@@@ map <silent> <a-]> :execute 'ptj 'TokenUnderCursor(0, 0)<cr>
map <tab> <c-w>w
map <s-tab> <c-w>W
" <c-i> is normally used as the opposite for <c-o>
" i'm using tab to switch windows so i use <a-o> as the opposite for <c-o>
noremap <a-o> <tab>

  " alt clipboard
vmap <a-y> "fy
vmap <a-d> "fd
map <a-p> "fp

"
" reviews
"
"@@@ map <silent> <f4> rvu
"@@@map <silent> <s-f4> :%s/  \([^ ]*\) \([0-9.]*\) -> \([0-9.]*\)/  \1 \3 <- \2/g<cr><cr>

"au BufNewFile,BufRead R* if bufname("%") =~ '\(^\|/\)R[0-9]\+$' && (getline(1) =~? "^OLD_NAME" || getline(1) =~ "^ID:" || getline(1) =~ "^TITLE:") | normal :%s/  \([^ ]*\) \([0-9.]*\) -> \([0-9.]*\)/  \1 \3 <- \2/g<cr><cr> | endif 
"map <silent> <a-f9> :execute ':!difm' TokenUnderCursor(1, 0) '&' <cr><cr>
"noremap <f1> :execute ':!cvsdiff' TokenUnderCursor(1, 0) '&' <cr><cr>
"noremap <f7> :execute ':!cvsdiff' TokenUnderCursor(1, 0) '&' <cr><cr>
noremap <f1> :execute ':!cvsdiff' expand("<cfile>") '&' <cr><cr>
noremap <f7> :execute ':!cvsdiff' expand("<cfile>") '&' <cr><cr>
noremap <s-f1> :execute ':!g' TokenUnderCursor(2, 0) <cr><cr>
noremap <a-f7> :execute ':!g' TokenUnderCursor(2, 0) <cr><cr>
noremap Rc /^STATUS:<cr>2wcwCLOSED<esc>
noremap Rs /^STATUS:<cr>2wcwRESPONDED<esc>
noremap Rv /^STATUS:<cr>2wcwREVIEWED<esc>
noremap Ra /^STATUS:<cr>2wcwDASSIGNED<esc>
noremap Rd /^STATUS:<cr>2wcwDRESPONDED<esc>
"noremap Rb yymlGo<esc>pd0ElC: [C] - <c-o>6h
noremap Rb yyml:wincmd j<cr>Go<esc>pd0ElC: [C] - <c-o>6h
"noremap gb :execute ':!/usr/bin/konqueror http://bugs/bugs_rg/show_bug.cgi?id='TokenUnderCursor(0, 1)
noremap Ry /^DREVIEWER:<cr>2wD/^REVIEWER:<cr>2wcwyoavp<esc>/^COMMITTER:<cr>2w:noh<cr>

map <silent> <f3> /\%>80v.\+\\|^\s*\n\s*$\\|[,;][^ ]\\|[,;] \s\\|\s[,;]\\|[^ 	]  [^ 	]\\|^   [^ 	]\\|^     [^ 	*]<cr>

"
" c/h
"
let c_syntax_for_h = 1
let c_cpp_comments = 1
let c_minlines = 144
let c_gnu = 1

map <silent> <s-f3> <c-home>O/*<space>LICENSE_CODE<space>JUNGO<space>*/<cr><esc>
map <silent> <a-f9> :!ctags -R<cr><cr>
map <silent> <c-f9> :!gtags -i<cr><cr>
map <c-\> :let basedir=system("jpwdrootn")<cr>:exec "cd " basedir . "/pkg"<cr><c-]>
"@@@
map <c-a-\> :let basedir=system("jpwdrootn")<cr>:exec "cd " basedir . "/os/linux-2.6"<cr><c-]>
map <c-a-]> mL:GtagsCursorRef<cr>
map <c-n> :cn<cr>
map <c-p> :cp<cr>

inoremap {} {<cr>}<up><cr>
"inoremap }} <esc>O{<esc>jo}<esc>k

"inoreab wh while<space>()<left>
inoremap 'wh while ()<left>
inoremap 'sw switch ()<left>
inoremap 'rt return
inoremap 'br break;
inoremap 'co continue;
inoremap 'sz sizeof()<left>
inoremap 'ty typedef<space>
inoremap 'un unsigned<space>
inoremap 'za zalloc_e(sizeof())<left><left>
inoremap 'ma malloc_e(sizeof())<left><left>
inoremap 'ka kos_alloc(sizeof(), KOS_ALLOC_)<esc>bba
inoremap 'ip in_addr_t 
inoremap 'rq request

inoremap #de #define<space>
inoremap #in #include<space>
inoremap #en #endif
inoremap #er #error<space>
inoremap #w  #warning<space>
inoremap #id #if defined()<left>
inoremap #ed #elif defined()<left>

inoremap 'lx CONFIG_RG_TARGET_LINUX
inoremap 'vx CONFIG_RG_TARGET_VXWORKS

"
" gvimdiff
"
noremap <F12> <c-W>hzRgg:set fdc=0<cr><c-W>lzRgg:set fdc=0<cr><c-l>
noremap <s-F12> :so ~/scripts/diftop.vim<cr>
imap <s-f19> <space>
cmap <s-f19> <space>

if &diff
  noremap <silent> <a-g> :diffget<cr>
  noremap <silent> <a-p> :diffput<cr>
  map <space> ]czz
  map <s-f19> [czz
  map <cr> ]czz
  map <s-cr> [czz
  map <silent> <f5> :diffup<cr>
  imap <silent> <f5> <esc>:diffup<cr>a
  map <silent> <f2> :set diffopt^=iwhite<cr>
  map <silent> <s-f2> :set diffopt-=iwhite<cr>
  map <silent> <a-d> :set diff!<cr>
  cnoreab q qa
  cnoreab qq q
  cnoreab x xa
  cnoreab xx x

  "set guifont=-schumacher-clean-medium-r-normal--13-130-75-75-c-60-iso646.1991-irv
  "set guifont=-Schumacher-Clean-Medium-R-Normal--13-130-75-75-C-60-ISO646.1991-IRV
  "set guifont=clean
  "@@@set guifont=fixed\ semi-condensed
  "@@@set guifont=-Misc-Fixed-Medium-R-SemiCondensed--13-120-75-75-C-60-ISO10646-1

  set go-=rRlL dip=filler,context:5000
  "@@@ either find a way to set fdc to 0 or find a way to know that we're not in
  " cvsdiff and set wiw to 82
  set lsp=3 wiw=80
  "@@@ this doesn't work - redone in diftop.vim
  set fdm=manual fdc=0
  set noea " set ea in diftop.vim
  "@@@ bring this back when you find good fonts: set co=161 lines=34
  set co=159 lines=32
endif

"
" menus
"
aunmenu Help 
aunmenu Window
aunmenu File

"
" cscope - system changes col!!
"
"if system("find cscope.out") != ""
"	cs add cscope.out
"	set cst
"endif
"
"reset lines columns, note that they were already set by diff
"
"cnoremap css cs show <cr>
"cnoremap csr cs reset <cr>
"cnoremap cfc cs find c 
"cnoremap cfd cs find d 
"cnoremap cfe cs find e 
"cnoremap cff cs find f 
"cnoremap cfg cs find g 
"cnoremap cfi cs find i 
"cnoremap cfs cs find s 
"cnoremap cft cs find t 
"cnoremap cf cs find  

function! IsTokenChar(is_fname, is_number, char)
      if a:char >= "0" && a:char <= "9"
	  return 1
      endif
      if a:is_number
	  return 0
      endif
      if a:char == "_"
	  return 1
      endif
      if a:char >= "A" && a:char <= "Z"
	  return 1
      endif
      if a:char >= "a" && a:char <= "z"
	  return 1
      endif
      if a:is_fname && (a:char == "/" || a:char == "." || a:char == "-" || a:char == "~")
	  return 1
      endif
      if a:is_fname == 2 && a:char == ":"
	  return 1
      endif
      return 0
endfunction

"@@@ TODO - can be replaced with:
" expend("<cfile>") / expand("cword") / expand("cWORD")
function! TokenUnderCursor(is_fname, is_number)
    echo ""
    let line = getline(".")
    let pos = col(".") - 1

    let begpos = pos -1
    while IsTokenChar(a:is_fname, a:is_number, strpart(line, begpos, 1)) == 1
	let begpos = begpos - 1
    endwhile
    
    let endpos = pos + 1
    while IsTokenChar(a:is_fname, a:is_number, strpart(line, endpos, 1)) == 1
	let endpos = endpos + 1
    endwhile

    let result = strpart(line, begpos+1, endpos-begpos-1)
    " to skip "rg/" in reviews, uncomment:
    "let result = strpart(line, begpos+4, endpos-begpos-1)

    return result
endfunction

"noremap cfc :execute ':cs find c' TokenUnderCursor(0) <cr>
"noremap cfd :execute ':cs find d' TokenUnderCursor(0) <cr>
"noremap cfe :execute ':cs find e' TokenUnderCursor(0) <cr>
"noremap cff :execute ':cs find f' TokenUnderCursor(0) <cr>
"noremap cfg :execute ':cs find g' TokenUnderCursor(0) <cr>
"noremap cfi :execute ':cs find i' TokenUnderCursor(0) <cr>
"noremap cfs :execute ':cs find s' TokenUnderCursor(0) <cr>
"noremap cft :execute ':cs find t' TokenUnderCursor(0) <cr>

" @@@ new experimental stuff
" needs containdin=everything
map <f8> :syn clear orange<cr>:exec 'syn match orange "\<' . expand("<cword>") . '\>"'<cr>:hi orange guifg=#e09000<cr><cr>
map <s-f8> :exec 'syn match orange "\<' . expand("<cword>") . '\>"'<cr>:hi orange guifg=#e09000<cr><cr>



" @@@ tab ptj ...?
map <a-]> :tab split<cr>g]

" cvs tabs - ann n log
nmap <a-a> :tab split<cr>\cn:set nowrap ft=ann<cr>
nmap <a-c> :tab split<cr>\cl

"@@@ temp, till i'll fix my display n fonts properly
"if &diff
"    set guifont=Monospace\ 13
"    map <f11> :set co=161 noea guifont=Monospace\ 12<cr>:set ea<cr>
"    map <f10> :set co=159 guifont=Monospace\ 13<cr><c-w>w<c-w>w
"else
"    set guifont=Monospace\ 14
"endif

" turn on cin in vim-7
filetype plugin indent on

" tabbed gf
map gf :tabe <cfile><cr>
map <silent> <c-a-n> :tab sp<cr>:enew<cr>

set cul

" see also :source ~/vim/macros/matchit.vim / matchit.txt
" @@@ redone on diftop or it doesn't work on diffs - yoy?
" the .* is for d%
" stopped working - yoy?
let b:match_words='<<<<<<<.*:=======:>>>>>>>.*,'


map <f9> :execute ':grep -r --include "*.[chiS]" "\<' . TokenUnderCursor(0, 0) . '\>" .' <cr>:cope 4<cr>:set nowrap<cr><cr>
map <f10> :execute ':grep --exclude=tags "\<' . TokenUnderCursor(0, 0) . '\>" * mk/*' <cr>:cope 4<cr>:set nowrap<cr><cr>

" doesn't work - update project/tools/vim to fix
let g:dont_load_funcheader=1


" on new gvim inst:
" remove set nomodeline from .../debian.vim
