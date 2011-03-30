setlocal makeprg=javac\ -g\ %
execute "noremap <buffer> <F6> :!jdb %:r<cr>"
