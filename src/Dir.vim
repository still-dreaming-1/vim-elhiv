function! Dir(path)
	let info= l_dir_info#new(a:path)
	let dir= {}
	let dir.path= info.path
	let dir._shell= Shell()

	function! dir.get_exists()
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

	function! dir.create_recursive()
		call self._shell.run('mkdir "'.self.path.'"')
	endfunction
	
	function! dir.copy_to(dir)
		if !a:dir.get_exists()
			call a:dir.create_recursive()
		endif
	endfunction

	function! dir.delete()
		call self._shell.run('rm -rf "'.self.path.'"')
	endfunction

	return dir
endfunction
