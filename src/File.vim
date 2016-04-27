function! File(path)
	let file= {}
	let file.path= a:path

	function! file.readable()
		return l_file_info#new(self.path).readable
	endfunction

	function! file.create()
		call Shell().run('touch "'.self.path.'"')
	endfunction

	function! file.delete()
		call Shell().run('rm "'.self.path.'"')
	endfunction

	return file
endfunction
