setlocal makeprg=php\ -l\ %
setlocal errorformat=%m\ in\ %f\ on\ line\ %l
let b:php_folding=1
setlocal keywordprg=~/.vim/bin/php_doc

" Debugger bindings
map <F6> :DbgRun<cr>
map <S-F6> :DbgDetach<cr>
map <leader>b :DbgToggleBreakpoint<cr>
map <leader>n :DbgStepInto<cr>
map <leader>N :DbgStepOver<cr>

au BufWritePost <buffer> call s:ShowErrors()

if exists("s:did_functions")
    finish
endif

sign define PHPError text=>> texthl=Error

function s:ShowErrors()
    silent make!
    call s:ClearErrors()
    for error in getqflist()
        if error.lnum != 0
            execute "sign place " . s:sign_id . " line=" . error.lnum . " name=PHPError file=" . expand("%:p")
        endif
        unlet error
    endfor

    " Possible fix for console vim. Flashes the screen though
    redraw!
endfunction

function s:ClearErrors()
    sign unplace *
    let s:sign_id = 1
    let s:errors = {}
endfunction

let s:did_functions=1
