setlocal makeprg=javac\ -g\ %
execute "noremap <F6> :!jdb %:r<cr>"
