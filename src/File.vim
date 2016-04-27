function! File(path)
	let file_info= l_file_info#new(a:path)
	let file= {}
	let file.path= file_info.path
	let file.readable= file_info.readable

	function! file.create()
	endfunction

	function! file.delete()
	endfunction

	return file
endfunction
