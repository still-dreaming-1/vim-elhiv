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

	function! dir.create()
		call self._shell.run('mkdir "'.self.path.'"')
	endfunction
	
	function! dir.copy_to(dir)
		if !a:dir.exists()
			call a:dir.create()
		endif
	endfunction

	function! dir.delete()
		call self._shell.run('rm -rf "'.self.path.'"')
	endfunction

	return dir
endfunction
