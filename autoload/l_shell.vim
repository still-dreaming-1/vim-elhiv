function! l_shell#new() abort
    let shell = {}

    function! shell.run(cmd) abort
        return system(a:cmd)
    endfunction

    return shell
endfunction
