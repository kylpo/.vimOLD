set nocompatible "first b/c others depend on this (no vi compat)

" load up everything in ~/.vim/bundle using pathogen.vim
""call pathogen#runtime_append_all_bundles()

""set path+=/usr/local/bin

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
""" B A S I C   O P T I O N S
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Tab completion
set wildmode=list:longest,list:full "make cmdline tab completion similar to bash
set wildmenu "enable ctrl-n and ctrl-p to scroll thru matches
set wildignore=*.o,*.obj,*~,pkg/* "stuff to ignore when tab completing
set wildignore+=*.o,*.obj,.git,*.rbc,*.class,.svn,vendor/gems/*

" Miscellaneous Options. Values:
"   a: ":read" sets window filename
"   A: ":write" sets window filename
"   B: backslash has no special meaning in ":map"
"   c: search continues from the end of the match
"   e: automatically add <CR> to the end of executed registers
"   F: ":write" sets buffer filename
"   s: set buffer options on entering the buffer
"   W: refuse to overwrite a readonly file, even with :w!
"   Z: don't reset 'readonly' when using :w!
set cpoptions=aABceFsWZ

""store lots of :cmdline history
set history=1000

" auto-reload any file modified outside vim
set autoread

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
""" E D I T I N G   O P T I O N S
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" allow backspacing over everything in insert mode
set backspace=indent,eol,start

""" FIXME: everything works as expected without these, I'm sure
"""        that I'm just missing something
"set cindent    " c-style language indentation
"set smartindent " automatically indent new lines

" for most code, use 2 space indents. specific filetypes are overridden
" in filetypes.vimrc
set smarttab
set softtabstop=2 " most of the time, we want a softtabstop of 2
set tabstop=2     " display tabs as 2 characters wide
set shiftwidth=2  " shift by 2 spaces when using >> and <<, etc
set expandtab     " no tabs, just spaces kthx.
set autoindent " automatically indent new lines

" Using autocmd for this allows it to be reset every time you open a
" file, which keeps overrides from being persistent
autocmd FileType * set softtabstop=2 tabstop=2 shiftwidth=2 expandtab

"set list                     " show whitespace
"set listchars=tab:»·,trail:· " show tabs and trailing spaces
"set listchars+=extends:»     " show a » when a line goes off the right
                             " edge of the screen
"set listchars+=precedes:«    " show a « when a line goes off the left
                             " edge of the screen

" formatting options:
" help fo-table
" t: automatically hard-wrap based on text-width
" c: do the same for comments, but
" r: autoinsert comment character too
" o: ditto, but for o/O in normal node
" q: allow 'gq' to autowrap/format comments as well as normal text
" 1: Don't break a line before a one-character word
" n: recognize numbered lists
set formatoptions+=tcroq1n
set formatoptions-=o "dont continue comments when pushing o/O

set nojoinspaces

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
""" F O L D I N G   O P T I O N S
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set foldenable        " enable folding
set foldmethod=syntax " use the syntax definitions' folding
set foldlevelstart=99 " start with all folds open when switching buffers
"set foldcolumn=3      " adds two columns of fold status on the left-hand
                      " side of the screen
"set foldmethod=indent "fold based on indent
"set foldnestmax=3 "deepest fold is 3 levels
"set nofoldenable "dont fold by default


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
""" S E A R C H   O P T I O N S
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set ignorecase " makes search patterns case-insensitive by default
set smartcase  " overrides ignorecase when the pattern contains
               " upper-case characters
set incsearch  " incremental search. 'nuf said
set hlsearch
set wrapscan " set the search scan to wrap lins

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
""" S W A P   A N D   U N D O   O P T I O N S
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"set writebackup
set directory=~/.vim/backup,/var/tmp,/tmp,.
set backup
set backupdir=~/.vim/backup

"enable persistent undo
if has("persistent_undo")
    set undofile
    set undodir=~/.vim/undofiles,/var/tmp,/tmp,.
endif

" Since I use linux, I want this
let g:clipbrdDefaultReg = '+'

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
""" W I N D O W   O P T I O N S
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
syntax on       " turn on syntax highlighting
"set number      " show line numbers
set showbreak=+ " display a + at the beginning of a wrapped line
set showmatch   " flash the matching bracket on inserting a )]} etc
set ruler          " shows cursor position in the lower right
set showcmd        " shows incomplete command to the left of the ruler
set showmode       " show the current mode
"set winminheight=0 " allow windows to be 0 lines tall
"set winminwidth=0  " allow windows to be 0 lines wide
set laststatus=2   " always show statusline
set nowrap "dont wrap lines
set linebreak "wrap lines at convenient points

" show at least 3 lines above/below cursor
set scrolloff=3
" and at least 7 columns next to cursor
set sidescrolloff=7
set sidescroll=1

"display tabs and trailing spaces
set list
set listchars=tab:▷⋅,trail:⋅,nbsp:⋅

" Set the textwidth to be 120 chars
set textwidth=120

" get rid of the silly characters in window separators
set fillchars=""

"set cursorline "highlight line of cursor

"only hightlight current window
autocmd WinEnter * setlocal cursorline
autocmd WinLeave * setlocal nocursorline


"statusline setup
set statusline=%f "tail of the filename
"display a warning if fileformat isnt unix
set statusline+=%#warningmsg#
set statusline+=%{&ff!='unix'?'['.&ff.']':''}
set statusline+=%*
"display a warning if file encoding isnt utf-8
set statusline+=%#warningmsg#
set statusline+=%{(&fenc!='utf-8'&&&fenc!='')?'['.&fenc.']':''}
set statusline+=%*
set statusline+=%h "help file flag
set statusline+=%y "filetype
set statusline+=%r "read only flag
set statusline+=%m "modified flag
"display a warning if &et is wrong, or we have mixed-indenting
set statusline+=%#error#
set statusline+=%{StatuslineTabWarning()}
set statusline+=%*
set statusline+=%{StatuslineTrailingSpaceWarning()}
set statusline+=%{StatuslineLongLineWarning()}
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*
"display a warning if &paste is set
set statusline+=%#error#
set statusline+=%{&paste?'[paste]':''}
set statusline+=%*
" git status if applicable
set statusline+=%{fugitive#statusline()}
set statusline+=%= "left/right separator
set statusline+=%{StatuslineCurrentHighlight()}\ \ "current highlight
set statusline+=%c, "cursor column
set statusline+=%l/%L "cursor line/total lines
set statusline+=\ %P "percent through file

" set up statusline, ends up looking like this:
"
"   [1] window.vimrc [Preview] [vim,+]          0x00 @ l22 c51 (88%)
"
" set statusline=
" set statusline+=%n:\                      " buffer number
" set statusline+=%f                        " filename
" set statusline+=%<                        " truncate here if necessary
" set statusline+=%10w                      " displays [Preview] if it is
" set statusline+=\ [                       " fix spacing, open bracket
" set statusline+=%{strlen(&ft)?&ft:'none'} " filetype
" set statusline+=%M                        " + if modified, - if r/o
" set statusline+=]                         " close bracket
" set statusline+=%=                        " right-align remainder
" set statusline+=0x%02B\                   " character hex value
" set statusline+=@\ L%l\ C%c\ (%P)\        " position in file
"set stl=%f\ %m\ %r\ Line:%l/%L[%p%%]\ Col:%c\ Buf:%n\ [%b][0x%B]

"hide buffers when not displayed
"set hidden

" current window always has a nice size
set winheight=10
" but the other windows aren't *too* small
set winminheight=3

" new splits go below the current buffer
set splitbelow
" and to the right as well
set splitright

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
""" FUNCTIONS
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"recalculate the trailing whitespace warning when idle, and after saving
autocmd cursorhold,bufwritepost * unlet! b:statusline_trailing_space_warning

"return '[\s]' if trailing white space is detected
"return '' otherwise
function! StatuslineTrailingSpaceWarning()
    if !exists("b:statusline_trailing_space_warning")
        if search('\s\+$', 'nw') != 0
            let b:statusline_trailing_space_warning = '[\s]'
        else
            let b:statusline_trailing_space_warning = ''
        endif
    endif
    return b:statusline_trailing_space_warning
endfunction


"return the syntax highlight group under the cursor ''
function! StatuslineCurrentHighlight()
    let name = synIDattr(synID(line('.'),col('.'),1),'name')
    if name == ''
        return ''
    else
        return '[' . name . ']'
    endif
endfunction

"recalculate the tab warning flag when idle and after writing
autocmd cursorhold,bufwritepost * unlet! b:statusline_tab_warning

"return '[&et]' if &et is set wrong
"return '[mixed-indenting]' if spaces and tabs are used to indent
"return an empty string if everything is fine
function! StatuslineTabWarning()
    if !exists("b:statusline_tab_warning")
        let tabs = search('^\t', 'nw') != 0
        let spaces = search('^ ', 'nw') != 0

        if tabs && spaces
            let b:statusline_tab_warning = '[mixed-indenting]'
        elseif (spaces && !&et) || (tabs && &et)
            let b:statusline_tab_warning = '[&et]'
        else
            let b:statusline_tab_warning = ''
        endif
    endif
    return b:statusline_tab_warning
endfunction

"recalculate the long line warning when idle and after saving
autocmd cursorhold,bufwritepost * unlet! b:statusline_long_line_warning

"return a warning for "long lines" where "long" is either &textwidth or 80 (if
"no &textwidth is set)
"
"return '' if no long lines
"return '[#x,my,$z] if long lines are found, were x is the number of long
"lines, y is the median length of the long lines and z is the length of the
"longest line
function! StatuslineLongLineWarning()
    if !exists("b:statusline_long_line_warning")
        let long_line_lens = s:LongLines()

        if len(long_line_lens) > 0
            let b:statusline_long_line_warning = "[" .
                        \ '#' . len(long_line_lens) . "," .
                        \ 'm' . s:Median(long_line_lens) . "," .
                        \ '$' . max(long_line_lens) . "]"
        else
            let b:statusline_long_line_warning = ""
        endif
    endif
    return b:statusline_long_line_warning
endfunction

"return a list containing the lengths of the long lines in this buffer
function! s:LongLines()
    let threshold = (&tw ? &tw : 80)
    let spaces = repeat(" ", &ts)

    let long_line_lens = []

    let i = 1
    while i <= line("$")
        let len = strlen(substitute(getline(i), '\t', spaces, 'g'))
        if len > threshold
            call add(long_line_lens, len)
        endif
        let i += 1
    endwhile

    return long_line_lens
endfunction

"find the median of the given array of numbers
function! s:Median(nums)
    let nums = sort(a:nums)
    let l = len(nums)

    if l % 2 == 1
        let i = (l-1) / 2
        return nums[i]
    else
        return (nums[l/2] + nums[(l/2)-1]) / 2
    endif
endfunction

function TabMove(n)
    let nr = tabpagenr()
    let size = tabpagenr('$')
    " do we want to go left?
    if (a:n != 0)
        let nr = nr - 2
    endif
    " crossed left border?
    if (nr < 0)
        let nr = size-1
        " crossed right border?
    elseif (nr == size)
        let nr = 0
    endif
    " fire move command
    exec 'tabm'.nr
endfunction

" strip leading tabs and trailing whitespace
command Tr %s/\s\+$//ge | %s/\t/ /ge | nohlsearch
command FixHashes %s/\(\S\)=>\(\S\)/\1 => \2/ge | %s/\t/ /ge | nohlsearch

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
""" C O L O R   O P T I O N S
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set t_Co=256 "for zenburn theme in terminal
"colo wombat256

syntax enable
set background=dark
colorscheme solarized

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
""" F I L E T Y P E   O P T I O N S
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" use filetype plugins to determine indent settings
filetype plugin indent on

" ruby and yaml files are indented by two
autocmd FileType ruby,rdoc,cucumber,yaml set softtabstop=2 tabstop=2 shiftwidth=2

" Gemfile, Isolate, Vagrantfile and config.ru are ruby
autocmd BufNewFile,BufRead Gemfile     setfiletype ruby
autocmd BufNewFile,BufRead Isolate     setfiletype ruby
autocmd BufNewFile,BufRead Vagrantfile setfiletype ruby
autocmd BufNewFile,BufRead config.ru   setfiletype ruby

" set up compiler for ruby files
autocmd FileType ruby compiler ruby

" don't show whitespace in help files
autocmd FileType help set nolist

" twiki files
autocmd BufNewFile,BufRead *.twiki set filetype=twiki

" set filetype on config files for vim, mutt, and bash
autocmd BufNewFile,BufRead ~/.vim/*  setfiletype vim
autocmd BufNewFile,BufRead ~/.mutt/* setfiletype muttrc
autocmd BufNewFile,BufRead ~/.bash/* setfiletype sh

"filetype plugin on
set ofu=syntaxcomplete#Complete

"autocmd FileType python set omnifunc=pythoncomplete#Complete
"autocmd FileType javascript set omnifunc=javascriptcomplete#CompleteJS
"autocmd FileType html set omnifunc=htmlcomplete#CompleteTags
"autocmd FileType css set omnifunc=csscomplete#CompleteCSS
"autocmd FileType xml set omnifunc=xmlcomplete#CompleteTags
"autocmd FileType php set omnifunc=phpcomplete#CompletePHP
"autocmd FileType c set omnifunc=ccomplete#Complete

""""""""""""""""""""""""""""""""""""""""""""""""""""
"" Python
"""""""""""""""""""""""""""""""""""""""""""""""""""
"autocmd BufWrite *.{py} :call Pyflakes()"
"python << EOL
"import vim
"# Do not say 'from vim import *' because that
"# will delete builtin function eval.

"def EvaluateCurrentLine(*args):
 " cur_str = vim.current.line
  "action, symb = None, None
"  for i in args:
"    if i in ["r","p"]: action = i
 "   else: symb = i
"  try: start = cur_str.rindex(symb)+len(symb)
"  except: start = 0
"  result = eval(cur_str[start:],globals())
"  if action == "r":
"    vim.current.line = cur_str[:start]+str(result)
"  else:
"    print result
"EOL
"command -narg=* PyEv python EvaluateCurrentLine(<f-args>)

command Pyflakes :call Pyflakes()
function! Pyflakes()
    let tmpfile = tempname()
    execute "w" tmpfile
    execute "set makeprg=(pyflakes\\ " . tmpfile . "\\\\\\|sed\\ s@" . tmpfile ."@%@)"
    make
    cw
endfunction

command Pylint :call Pylint()
function! Pylint()
    setlocal makeprg=(echo\ '[%]';\ pylint\ %)
    setlocal efm=%+P[%f],%t:\ %#%l:%m
    silent make
    cwindow
endfunction

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
""" K E Y   B I N D I N G S
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let mapleader=',' " set leader to ,

" Up and down are more logical with g..
"nnoremap <silent> k gk
"nnoremap <silent> j gj

" format paragraphs (72 columns)
map ^^ {!}par w72qrg<CR>

" one-stroke window maximizing
"map <C-H> <C-W>h<C-W><BAR>
"map <C-L> <C-W>l<C-W><BAR>
"map <C-J> <C-W>j<C-W>_
"map <C-K> <C-W>k<C-W>_

" quick buffer switching
map <leader>[ :bprevious<CR>
map <leader>] :bnext<CR>

" shortcut to compile/run the current file
map <leader>r :w<CR>:make %<CR>

" shortcut to strip trailing whitespace
map <leader>s :s/\s\+$//g<CR>

" fold helpers:
"   Tab: toggle fold state
"   Shift-Tab: toggle state of outermost fold
"   Ctrl-Tab: open all folds
map <TAB> za
map <S-TAB> zA
map <C-TAB> zR

" Maps to make handling windows a bit easier
noremap <silent> ,h :wincmd h<CR>
noremap <silent> ,j :wincmd j<CR>
noremap <silent> ,k :wincmd k<CR>
noremap <silent> ,l :wincmd l<CR>
noremap <silent> ,sb :wincmd p<CR>
noremap <silent> <C-F9>  :vertical resize -10<CR>
noremap <silent> <C-F10> :resize +10<CR>
noremap <silent> <C-F11> :resize -10<CR>
noremap <silent> <C-F12> :vertical resize +10<CR>
noremap <silent> ,s8 :vertical resize 83<CR>
noremap <silent> ,cj :wincmd j<CR>:close<CR>
noremap <silent> ,ck :wincmd k<CR>:close<CR>
noremap <silent> ,ch :wincmd h<CR>:close<CR>
noremap <silent> ,cl :wincmd l<CR>:close<CR>
noremap <silent> ,cc :close<CR>
noremap <silent> ,cw :cclose<CR>
noremap <silent> ,ml <C-W>L
noremap <silent> ,mk <C-W>K
noremap <silent> ,mh <C-W>H
noremap <silent> ,mj <C-W>J
noremap <silent> <C-7> <C-W>>
noremap <silent> <C-8> <C-W>+
noremap <silent> <C-9> <C-W>+
noremap <silent> <C-0> <C-W>>

"make <c-l> clear the highlight as well as redraw
"TODO fix keys
nnoremap <m-l> :nohls<CR><m-l>
inoremap <m-l> <C-O>:nohls<CR>

" Map ctrl-movement keys to window switching
map <C-k> <C-w><Up>
map <C-j> <C-w><Down>
map <C-l> <C-w><Right>
map <C-h> <C-w><Left>
map <C-_> <C-w>_
" Adjust viewports to the same size
map <Leader>= <C-w>=
imap <Leader>= <Esc> <C-w>=

map <C-Left> :call TabMove(1)<CR>
map <C-Right> :call TabMove(0)<CR>

" allow a more natural style of line editing in :ex mode
cnoremap <C-A> <Home>
cnoremap <C-E> <End>
cnoremap <C-F> <Right>
cnoremap <C-B> <Left>

"nmap <F3> I<C-R>=strftime("%Y-%m-%d %a %I:%M %p")<CR> - <Esc>
""imap <F3> <Esc>I<C-R>=strftime("%Y-%m-%d %a %I:%M %p")<CR> - <Esc>
nmap <F5> o<C-R>=strftime("%I:%M %p")<CR> - 
imap <F5> <Esc>o<C-R>=strftime("%I:%M %p")<CR> - 
iab *** <Esc>I#<Esc>
nmap <F6> <Esc>I#<Esc>
imap <F6> <Esc>I#<Esc>

map <F2> NERDTreeToggle
map <F3> "+P
map! <F3> <C-R>+
set pastetoggle=<F4>

inoremap <Nul> <C-x><C-o> 

" Execute file being edited with <Shift> + e:
map <buffer> <S-e> :w<CR>:!/usr/bin/env python % <CR>

"map Q to something useful
noremap Q gq

"make Y consistent with C and D
nnoremap Y y$

" easy escape
imap jj <Esc>

" Bubble single lines
nmap <C-Up> [e
nmap <C-Down> ]e
" Bubble multiple lines
vmap <C-Up> [egv
vmap <C-Down> ]egv

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
""" P L U G I N   O P T I O N S
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
""" bufexplorer
let g:bufExplorerDetailedHelp=1     " show full help text by default
" let g:bufExplorerShowRelativePath=1 " use relative paths
let g:bufExplorerShowUnlisted=1     " display unlisted buffers
nnoremap <leader>b :BufExplorer<cr>

""" NERDCommenter
let NERDCreateDefaultMappings=0 " disable default mappings
let NERDMenuMode=0              " disable menu
let NERDSpaceDelims=1           " place spaces after comment chars
let NERDDefaultNesting=0        " don't recomment commented lines

map <leader>cc <plug>NERDCommenterToggle
map <leader>cC <plug>NERDCommenterSexy
map <leader>cu <plug>NERDCommenterUncomment

" NERDTree configuration
let NERDTreeIgnore=['\.pyc$', '\.rbc$', '\~$']
map <Leader>n :NERDTreeToggle<CR>

" Command-T configuration
let g:CommandTMaxHeight=20

""" Tabular
" sets ,l to align = and => lines
map <leader>l :Tabularize /=>\?<cr>

""" Taglist
map <leader>t :TlistToggle<cr>

let Tlist_Ctags_Cmd = "/usr/bin/ctags"
let Tlist_WinWidth = 50

"map <F8> :!/usr/bin/ctags -R --c++-kinds=+p --fields=+iaS --extra=+q .<CR>
" map <leader>c :!ctags *.*<CR>
" CTags
map <Leader>rt :!ctags --extra=+f -R *<CR><CR>
map <C-\> :tnext<CR>

" Enable syntastic syntax checking
let g:syntastic_enable_signs=1
let g:syntastic_quiet_warnings=1

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
""" GUI
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
if !has("gui")
  "dont load csapprox if we no gui support - silences an annoying warning
  let g:CSApprox_loaded = 1

  " set custom cursor -- vertical bar in insert mode (iTerm2)
  " from http://www.iterm2.com/#/section/documentation/escape_codes
  let &t_SI = "\<Esc>]50;CursorShape=1\x7"
  let &t_EI = "\<Esc>]50;CursorShape=0\x7"
endif

if has("gui_running")
    source $HOME/.vim/gvimrc
endif

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
""" PLATFORM
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
if has("mac")
  "let g:gist_clip_command = 'pbcopy'
elseif has("unix")
  "let g:gist_clip_command = 'xclip -selection clipboard'
endif

