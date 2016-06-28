function! L_current_buffer()
	let buf= {}

	function! buf.dir()
		return L_dir(expand("%:p:h"))
	endfunction

	function! buf.file()
		return L_file(expand('%:p'))
	endfunction

	return buf
endfunction
