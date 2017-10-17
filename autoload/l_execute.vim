function! l_execute#leader_with(suffix) abort
    let l:leader = get(g:, 'mapleader', "\\")
    if l:leader ==# ' '
        let l:leader = '1' . l:leader
    endif
    execute 'normal '.l:leader.a:suffix
endfunction
