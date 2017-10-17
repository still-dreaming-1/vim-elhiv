function! l_profiler#new() abort
    let profiler = {}
    let profiler.running = 0

    " Warning! This also sources the files you want to profile. This is the only way to ensure they will actually be profiled in case they were already sourced.
    function! profiler.start(log_path, dir_with_files_to_profile) abort
        if self.running
            " prevents infinite recursion since the other Profile class uses this in a static way and this method sources files.
            return
        endif
        let self.running = 1
        execute 'profile start '.a:log_path
        execute 'profile! file'.fnameescape(a:dir_with_files_to_profile.path).'/*.vim'
    endfunction

    function! profiler.stop() abort
        if self.running
            profile stop
            let self.running = 0
        endif
    endfunction

    return profiler
endfunction
