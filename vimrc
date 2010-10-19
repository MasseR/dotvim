call pathogen#runtime_append_all_bundles() 
source /usr/share/vim/vim72/vimrc_example.vim
filetype on
filetype plugin indent on
syntax on

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


let OmniCpp_NamespaceSearch = 1
let OmniCpp_GlobalScopeSearch = 1
let OmniCpp_ShowAccess = 1
let OmniCpp_MayCompleteDot = 1
let OmniCpp_MayCompleteArrow = 1
let OmniCpp_MayCompleteScope = 1
let OmniCpp_DefaultNamespaces = ["std", "_GLIBCXX_STD"]
" Automatically open popup
autocmd CursorMovedI * if pumvisible() == 0|pclose|endif
autocmd InsertLeave * if pumvisible() == 0|pclose|endif
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

" Remap \bl to :e # (Open the last edited buffer)
noremap \bl :e #<cr>

" Remap <F5> to :make
noremap <F5> :make<cr>

" Show tabs
set list listchars=tab:»·

" Set default foldmethod
set foldmethod=syntax

" Drupal filetype detections
au BufRead,BufNewFile *.module	set filetype=php " Drupal module
au BufRead,BufNewFile *.install	set filetype=php " Drupal install file
au BufRead,BufNewFile *.inc	set filetype=php " Generic php include
au BufRead,BufNewFile *.info	set filetype=dosini " Drupal ini file
" Haxe filetype detection
au BufRead,BufNewFile *.hx set filetype=haxe

" Document filetype detections
autocmd BufReadPost *.doc silent %!antiword "%"
autocmd BufReadPost *.odt,*.odp silent %!odt2txt "%"
autocmd BufReadPost *.pdf silent %!pdftotext -nopgbrk -layout -q -eol unix "%" - | fmt -w78
autocmd BufReadPost *.rtf silent %!unrtf --text "%"

" Enable text editing features
autocmd BufRead,BufNewFile *.txt set fo+=a " Paragraph formatting
autocmd BufRead,BufNewFile *.txt set textwidth=75
autocmd BufRead,BufNewFile *.txt set spell spelllang=en_us

" Set proper filetype for latex
au BufRead,BufNewFile *.tex set filetype=tex

" Twitter > Identi.ca
let twitvim_api_root = "http://identi.ca/api"
let twitvim_browser_cmd = "firefox"

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
map \l :call LoadSession()<cr>
au VimLeave * :call MakeSession()

" notes syntax 
augroup filetypedetect
	au BufNewFile,BufRead *.notes setf notes
augroup END

"set expandtab
set textwidth=0
"set tabstop=4
set softtabstop=4
set shiftwidth=4
set autoindent
"set backspace=indent,eol,start
set ruler
set wildmenu

" Load folds etc
au BufWinLeave *.py mkview
au BufWinEnter *.py silent loadview

" Backups
set backup

set statusline=%<\ %n:%f\ %m%r%y%=%-35.(line:\ %l\ of\ %L,\ col:\ %c%V\ (%P)%)
set laststatus=2

set backupdir=~/.backup/

let g:haddock_browser="firefox"