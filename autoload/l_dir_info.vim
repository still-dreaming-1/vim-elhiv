function! l_dir_info#new(path)
	let dir= {}
	let dir.path= a:path
	let dir.exists= isdirectory(a:path)

	function! dir.parent()
		let last_slash_idx= strridx(self.path, '/', len(self.path) - 2)
		if last_slash_idx < 1 "0 or -1
			return l_null#new()
		endif
		return l_dir_info#new(self.path[0:last_slash_idx - 1])
	endfunction

	function! dir.get_contained_dir_info(name)
		return l_dir_info#new(self.path.'/'.a:name)
	endfunction

	function! dir.get_contained_file_info(name)
		return l_file_info#new(self.path.'/'.a:name)
	endfunction

	function! dir.get_all_file_info()
		let out= S(Shell().run('find "'.self.path.'" -maxdepth 1 -type f'))
		let path_list= split(out.str, "\n")
		let my_path= self.path.'/'
		let all_file_info= []
		for file_path in path_list
			if !S(file_path).starts_with(my_path)
				return []
			endif
			call add(all_file_info, l_file_info#new(file_path))
		endfor
		return all_file_info
	endfunction

	return dir
endfunction
