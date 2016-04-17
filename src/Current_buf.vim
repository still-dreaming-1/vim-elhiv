function! Current_buf()
	let l:buf= {}

	function! l:buf.dir()
		return Dir(expand("%:p:h"))
	endfunction

	return l:buf
endfunction
