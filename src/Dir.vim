function! Dir(path)
	let dir= {}
	let dir.path= a:path
	let dir._shell= Shell()

	function! dir.exists()
		return l_dir_info#new(self.path).exists
	endfunction

	function! dir.parent()
		let parent_info= l_dir_info#new(self.path).parent()
		if parent_info == Null()
			return parent_info
		endif
		return Dir(parent_info.path)
	endfunction

	function! dir.get_contained_dir(name)
		let contained_info= l_dir_info#new(self.path).get_contained_dir_info(a:name)
		return Dir(contained_info.path)
	endfunction

	function! dir.get_contained_file(name)
		let contained_info= l_dir_info#new(self.path).get_contained_file_info(a:name)
		return File(contained_info.path)
	endfunction

	function! dir.contains_file_path_recursive(path)
		let file= File(a:path)
		return S(file.path).starts_with(self.path) && file.readable()
	endfunction

	function! dir.get_all_files()
		let all_files= []
		let all_file_info= l_dir_info#new(self.path).get_all_file_info()
		for file_info in all_file_info
			call add(all_files, File(file_info.path))
		endfor
		return all_files
	endfunction

	function! dir.get_all_files_recursive()
		let all_files_recursive= []
		let all_dirs= self.get_all_dirs_recursive()
		call add(all_dirs, self)
		for dir in all_dirs
			let all_files= dir.get_all_files()
			for file in all_files
				call add(all_files_recursive, file)
			endfor
		endfor
		return all_files_recursive
	endfunction

	function! dir.get_all_dirs()
		let all_dir_list= []
		let shell= Shell()
		let out= S(shell.run('find '.shellescape(self.path).' -maxdepth 1 -type d'))
		let path_list= split(out.str, "\n")
		let my_path= self.path.'/'
		for dir_path in path_list
			if dir_path !=# my_path && S(dir_path).starts_with(my_path)
				call add(all_dir_list, Dir(dir_path))
			endif
		endfor
		return all_dir_list
	endfunction

	function! dir.get_all_dirs_recursive()
		let all_dirs_recursive= []
		let all_dirs= self.get_all_dirs()
		call extend(all_dirs_recursive, all_dirs)
		for dir in all_dirs
			call extend(all_dirs_recursive, dir.get_all_dirs_recursive())
		endfor
		return all_dirs_recursive
	endfunction

	function! dir.get_files_with_extension_recursive(extension)
		let all_files= self.get_all_files_recursive()
		let all_files_with_extension= []
		for file in all_files
			if S(file.path).ends_with('.'.a:extension)
				call add(all_files_with_extension, file)
			endif
		endfor
		return all_files_with_extension
	endfunction

	function! dir.create()
		call self._shell.run('mkdir '.shellescape(self.path))
	endfunction
	
	function! dir.copy_to(dir)
		if !a:dir.exists()
			call a:dir.create()
		endif
	endfunction

	function! dir.delete()
		call self._shell.run('rm -rf '.shellescape(self.path))
	endfunction

	function! dir.is_subdir_of(dir)
		return a:dir.has_subdir(self)
	endfunction

	function! dir.has_subdir(dir)
		if !self.exists()
			return 0
		endif
		if !a:dir.exists()
			return 0
		endif
		if S(a:dir.path).starts_with(self.path)
			return 1
		endif
		return 0
	endfunction

	return dir
endfunction
