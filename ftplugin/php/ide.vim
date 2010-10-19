autocmd FileType php set omnifunc=phpcomplete#CompletePHP
autocmd CursorMovedI * if pumvisible() == 0|pclose|endif
autocmd InsertLeave * if pumvisible() == 0|pclose|endif
set completeopt=menuone,menu,longest
inoremap <Nul> <C-x><C-o>
