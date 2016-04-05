function! l_buf#current()
	let l:buf= {}
	function! l:buf.dir()
		return l_dir#new(expand("%:p:h"))
	endfunction
	return l:buf
endfunction
