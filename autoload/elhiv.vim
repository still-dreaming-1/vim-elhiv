function! elhiv#parse_parent_dir(dir_path)
	let l:last_slash_idx= l_s#ridx(a:dir_path, '/', len(a:dir_path) - 2)
	if l:last_slash_idx < 1 "0 or -1
		return ''
	endif
	return a:dir_path[0:l:last_slash_idx - 1]
endfunction

function! elhiv#get_cursor_char()
	return getline(".")[col(".")-1]
endfunction
