function! elhiv#parse_parent_dir(dir_path)
	let l:parent_dir= system("dirname '".a:dir_path."'")
	let l:len = len(l:parent_dir)
	if l:parent_dir[l:len - 1] == "\n"
		let l:parent_dir= l:parent_dir[0 : l:len - 2]
	endif
	if l:parent_dir == '.' && type(l:parent_dir) == 1
		return 0
	endif
	return l:parent_dir
endfunction
