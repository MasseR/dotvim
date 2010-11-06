"
" general Haskell source settings
" (shared functions are in autoload/haskellmode.vim)
"
" (Claus Reinke, last modified: 28/04/2009)
"
" part of haskell plugins: http://projects.haskell.org/haskellmode-vim
" please send patches to <claus.reinke@talk21.com>

" try gf on import line, or ctrl-x ctrl-i, or [I, [i, ..
let s:path = "%"
let s:ipath = ""
while strlen(expand(s:path)) > 1
    let s:path = s:path . ":h"
    let s:ipath = s:ipath . ":" . expand(s:path)
endwhile
let b:ghc_staticoptions="-i" . s:ipath
compiler ghc
setlocal include=^import\\s*\\(qualified\\)\\?\\s*
setlocal includeexpr=substitute(v:fname,'\\.','/','g').'.'
setlocal suffixesadd=hs,lhs,hsc
setlocal shiftwidth=2
setlocal softtabstop=2
" setlocal makeprg=ghc\ --make\ %
setlocal conceallevel=2
execute "noremap <F6> :!ghci " . b:ghc_staticoptions . " %<cr>"
