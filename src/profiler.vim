function! profiler#start(log_path, dir_with_files_to_profile)
	if !exists('g:elhiv_profiler')
		let g:elhiv_profiler= l_profiler#new()
	endif
	call g:elhiv_profiler.start(a:log_path, a:dir_with_files_to_profile)
endfunction

function! profiler#stop()
	call g:elhiv_profiler.stop()
endfunction
