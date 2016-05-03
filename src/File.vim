function! File(path)
	let file= {}
	let file.path= a:path

	function! file.readable()
		return l_file_info#new(self.path).readable
	endfunction

	function! file.writable()
		let writable= filewritable(self.path)
		if writable == 1
			return 1
		endif
		return 0
	endfunction

	function! file.create()
		call Shell().run('touch "'.self.path.'"')
	endfunction

	function! file.delete()
		call Shell().run('rm "'.self.path.'"')
	endfunction

	function! file.edit()
		let editable_path= S(self.path).escape(' ')
		execute "e '".editable_path."'"
	endfunction

	return file
endfunction
