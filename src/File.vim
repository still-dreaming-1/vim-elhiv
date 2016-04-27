function! File(path)
	let file= {}
	let file.path= a:path

	function! file.readable()
		return l_file_info#new(self.path).readable
	endfunction

	function! file.create()
	endfunction

	function! file.delete()
	endfunction

	return file
endfunction
