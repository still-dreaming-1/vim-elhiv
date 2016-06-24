function! L_current_cursor()
	let cursor= {}

	function! cursor.word()
		return expand('<cword>')
	endfunction

	return cursor
endfunction
