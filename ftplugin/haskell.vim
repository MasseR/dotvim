"
" general Haskell source settings
" (shared functions are in autoload/haskellmode.vim)
"
" (Claus Reinke, last modified: 28/04/2009)
"
" part of haskell plugins: http://projects.haskell.org/haskellmode-vim
" please send patches to <claus.reinke@talk21.com>

" try gf on import line, or ctrl-x ctrl-i, or [I, [i, ..
compiler ghc
setlocal include=^import\\s*\\(qualified\\)\\?\\s*
setlocal includeexpr=substitute(v:fname,'\\.','/','g').'.'
setlocal suffixesadd=hs,lhs,hsc
setlocal shiftwidth=2
setlocal softtabstop=2
" setlocal makeprg=ghc\ --make\ %
setlocal conceallevel=2
noremap <F6> :!ghci %<cr>
