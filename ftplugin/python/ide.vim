python << EOF
import os
import sys
import vim
for p in sys.path:
	if os.path.isdir(p):
		vim.command(r"set path+=%s"%(p.replace(" ",r"\ ")))
EOF
set tags+=$HOME/.vim/tags/python.ctags
autocmd FileType python set omnifunc=pythoncomplete#Complete
autocmd CursorMovedI * if pumvisible() == 0|pclose|endif
autocmd InsertLeave * if pumvisible() == 0|pclose|endif
set completeopt=menuone,menu,longest
inoremap <Nul> <C-x><C-o>
noremap <buffer> <F6> :!ipython %<cr>
