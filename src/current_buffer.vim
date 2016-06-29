function! L_current_buffer()
	let buf= {}

	function! buf.dir()
		return L_dir(expand("%:p:h"))
	endfunction

	function! buf.file()
		return L_file(expand('%:p'))
	endfunction

	function! buf.append_line(line_or_list)
		call append(line('$'), a:line_or_list)
	endfunction

	return buf
endfunction
