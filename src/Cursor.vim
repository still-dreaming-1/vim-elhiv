function! Current_cursor()
	let l:cursor= {}
	function! l:cursor.word()
		return expand('<cword>')
	endfunction
	return l:cursor
endfunction
