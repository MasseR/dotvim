function! DirExists(dir)
    let s:exists = finddir(a:dir)
    if s:exists == ""
	return 0
    else
	return 1
    endif
endfunction

function! Mkbuilddir(builddir)
    if !DirExists(a:builddir)
	call mkdir(a:builddir)
    endif

    if !(isdirectory(a:builddir))
	echo a:builddir . " is not directory!"
    endif
    unlet s:exists
endfunction

function! Build(action)
    let s:curdir = getcwd()
    let s:builddir = s:curdir . "/build"

    call Mkbuilddir(s:builddir)

    execute "cd " . s:builddir

    if !DirExists(s:builddir . "CMakeFiles")
	!cmake ../
    endif

    execute a:action

    execute "cd " . s:curdir

    unlet s:builddir
    unlet s:curdir
endfunction

noremap <F5> :call Build("make")<cr>
noremap <F6> :call Build("make test")<cr>
let s:tags = getcwd() . "/tags"
let &tags = &tags . "," . s:tags
set omnifunc=omni#cpp#complete#Main
