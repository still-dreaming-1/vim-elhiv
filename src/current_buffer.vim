function! L_current_buffer()
	let buf= {}

	function! buf.dir()
		return Dir(expand("%:p:h"))
	endfunction

	function! buf.file()
		return File(expand('%:p'))
	endfunction

	return buf
endfunction
