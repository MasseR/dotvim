
set hidden " For lustyexplorer
" Pathogen requires restarting the filetype plugins
filetype off
" call pathogen#runtime_append_all_bundles()


let s:source=globpath(&rtp, "vimrc_example.vim")

" Init vundle
execute ":source " . globpath(&rtp, "vundlerc")

execute ":source " . s:source
unlet s:source
filetype on
filetype plugin indent on
syntax on

" I think we can trust urxvt having 256 colors
if $TERM == "rxvt-unicode"
    set t_Co=256
endif
" Zenburn
" set t_Co=256
" Fallback
colorscheme elflord
if &t_Co == 256
  colorscheme zenburn
endif
" Setting up omnicpp
" Enable omni
""""""""""""""""""""""
autocmd FileType python set omnifunc=pythoncomplete#Complete
autocmd FileType javascript set omnifunc=javascriptcomplete#CompleteJS
autocmd FileType html set omnifunc=htmlcomplete#CompleteTags
autocmd FileType css set omnifunc=csscomplete#CompleteCSS
autocmd FileType xml set omnifunc=xmlcomplete#CompleteTags
autocmd FileType php set omnifunc=phpcomplete#CompletePHP
autocmd FileType c set omnifunc=ccomplete#Complete

let php_sql_query=1
let php_htmlInStrings=1


let OmniCpp_NamespaceSearch = 1
let OmniCpp_GlobalScopeSearch = 1
let OmniCpp_ShowAccess = 1
let OmniCpp_MayCompleteDot = 1
let OmniCpp_MayCompleteArrow = 1
let OmniCpp_MayCompleteScope = 1
let OmniCpp_DefaultNamespaces = ["std", "_GLIBCXX_STD"]
" Automatically open popup
autocmd CursorMovedI *.* if pumvisible() == 0|pclose|endif
autocmd InsertLeave *.* if pumvisible() == 0|pclose|endif
set completeopt=menuone,menu,longest
"""""""""""""""""""""""
" End omnicpp
"""""""""""""""""""""""

" Mouse on
set mouse="a"

" Abbreviations
" Replace =! with !=
abbr =! !=
abbr itn int
abbr iint int
" I typo lists often
abbr [9 []
" In erlang, functions are separated with a semicolon unless it's the last one
abbr .; .
abbr functoin function

" Remap \bl to :e # (Open the last edited buffer)
noremap \bl :e #<cr>

" Remap <F5> to :make
noremap <F5> :make<cr>

" Show tabs
set list listchars=tab:»·

" Set default foldmethod
set foldmethod=syntax

" Drupal filetype detections
au BufRead,BufNewFile *.module  set filetype=php " Drupal module
au BufRead,BufNewFile *.install set filetype=php " Drupal install file
au BufRead,BufNewFile *.inc     set filetype=php " Generic php include
au BufRead,BufNewFile *.info    set filetype=dosini " Drupal ini file
" Haxe filetype detection
au BufRead,BufNewFile *.hx set filetype=haxe

" ClojureScript filetype detection
au BufRead,BufNewFile *.cljs set filetype=clojure
au BufRead,BufNewFile *.cljs call PareditInitBuffer()

" Document filetype detections
autocmd BufReadPost *.doc silent %!antiword "%"
autocmd BufReadPost *.odt,*.odp silent %!odt2txt "%"
autocmd BufReadPost *.pdf silent %!pdftotext -nopgbrk -layout -q -eol unix "%" - | fmt -w78
autocmd BufReadPost *.rtf silent %!unrtf --text "%"

" Enable text editing features
autocmd BufRead,BufNewFile *.txt set textwidth=75

" Set proper filetype for latex
au BufRead,BufNewFile *.tex set filetype=tex

" Twitter > Identi.ca
let twitvim_api_root = "http://identi.ca/api"
let twitvim_browser_cmd = "firefox"
let g:haddock_browser="firefox"
let g:haddock_indexfiledir="$HOME/.cabal/"

" Load sessions
function! MakeSession()
  let b:sessiondir = $HOME . "/.vim-sessions" . getcwd()
  if (filewritable(b:sessiondir) != 2)
    exe 'silent !mkdir -p ' b:sessiondir
    redraw!
  endif
  let b:filename = b:sessiondir . '/session.vim'
  exe "mksession! " . b:filename
endfunction

function! LoadSession()
  let b:sessiondir = $HOME . "/.vim-sessions" . getcwd()
  let b:sessionfile = b:sessiondir . "/session.vim"
  if (filereadable(b:sessionfile))
    exe 'source ' b:sessionfile
  else
    echo "No session loaded."
  endif
endfunction
" map \l :call LoadSession()<cr>
" au VimLeave * :call MakeSession()

" notes syntax 
augroup filetypedetect
        au BufNewFile,BufRead *.notes setf notes
        au BufNewFile,BufRead *.qml set filetype=qml
augroup END

"set expandtab
set textwidth=0
set expandtab
set softtabstop=4
set shiftwidth=4
set autoindent
"set backspace=indent,eol,start
set ruler
set wildmenu

" Backups
set backup

set statusline=%<\ %n:%f\ %m%r\ #%b\ %y%=%-35.(line:\ %l\ of\ %L,\ col:\ %c%V\ (%P)%)
set laststatus=2

set backupdir=~/.backup/


if version >= 703
    set undofile
    set undodir=$HOME/.vim-undos/
endif

" Notes directory
set tags+=$HOME/.tdoc

" Swap the backtick and single quote
" nnoremap ' `
" nnoremap ` '
" Load custom syntax files
so $HOME/.vim/syntax/whitespace.vim

" Open a terminal opened to the current directory
noremap <F12> :call system("urxvtc -cd " . expand("%:p:h"))<cr>

" Toggle Gundo window
noremap <F2> :GundoToggle<cr>

" Gui options
set guioptions-=m " No menu
set guioptions-=T " No toolbar
" Inconsolata font for gvim
set guifont=Inconsolata\ Medium\ 11

" Read project settings
if filereadable(".project.vim")
    source .project.vim
endif

" http://vim.wikia.com/wiki/Keep_folds_closed_while_inserting_text
autocmd InsertEnter * if !exists('w:last_fdm') | let w:last_fdm=&foldmethod | setlocal foldmethod=manual | endif
autocmd InsertLeave,WinLeave * if exists('w:last_fdm') | let &l:foldmethod=w:last_fdm | unlet w:last_fdm | endif

" Tags handling
" Provide a default for complete tag writing and partial updating
let g:completetags = "ctags-exuberant --exclude=Session.vim -R ."
let g:partialtags = "ctags-exuberant --exclude=Session.vim --append % tags"
autocmd BufNewFile *.* :let b:completetags = g:completetags
autocmd BufNewFile *.* :let b:partialtags = g:partialtags
autocmd BufReadPre *.* :let b:completetags = g:completetags
autocmd BufReadPre *.* :let b:partialtags = g:partialtags
autocmd BufWritePost *.* :let b:partialtags = g:partialtags
autocmd BufWritePost *.* :silent :execute ":!" . b:partialtags
noremap <F3> :execute ":!" . b:completetags <cr>

" Cscope handling.
" Enable this only for java for now
let g:completecscope = "find . -iname '*.java' >> cscope.files && cscope -b"
let g:partialcscope = "cscope -b"
let g:cscope_cmd = ""
autocmd BufWritePost *.java :silent :execute ":!" . g:partialcscope . " && " . b:partialtags
noremap <F4> :execute ":!" . g:completecscope <cr>


" My attempt to simplify some operations. Creating mappings for some common
" operations

" Text layout mappings

" New items separated by commas to new lines
noremap <leader>,r mx:s/,/,\r/g<cr>='x

" Inlinexml to formatted xml
noremap <leader>>< mx:%s/> *</>\r</g<cr>gg=G'x


function! RestoreSession()
    if filereadable("Session.vim")
        source Session.vim
    endif
endfunction

autocmd VimLeave * :mksession!

let g:EclimCompletionMethod = 'omnifunc'
source ~/.vim/defaultneocomplsettings.vim

" CtrlP config
let g:ctrlp_cmd = "CtrlPBufTag"
