setlocal makeprg=php\ -l\ %
setlocal errorformat=%m\ in\ %f\ on\ line\ %l
let b:php_folding=1

" Debugger bindings
map <F6> :DbgRun<cr>
map <S-F6> :DbgDetach<cr>
