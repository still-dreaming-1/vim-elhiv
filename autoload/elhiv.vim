function! elhiv#parse_parent_dir(dir_path)
	let l:last_slash_idx= strridx(a:dir_path, '/', len(a:dir_path) - 1)
	if l:last_slash_idx < 1 "0 or -1
		return ''
	endif
	return a:dir_path[0, l:last_slash_idx - 1]
endfunction
