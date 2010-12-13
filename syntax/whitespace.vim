" Hilights unwanted whitespace with red color (trailing whitespaces)
" From http://vim.wikia.com/wiki/Highlight_unwanted_spaces
" Can fail if other syntax files reset. See more information from the link
" above
highlight ExtraWhiteSpace ctermbg=red guibg=red
autocmd ColorScheme * highlight ExtraWhiteSpace ctermbg=red guibg=red
match ExtraWhiteSpace /\s\+$/
