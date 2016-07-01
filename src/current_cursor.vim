function! L_current_cursor()
	let cursor= {}

	function! cursor.word()
		return expand('<cword>')
	endfunction

	function! cursor.char()
		return getline(".")[col(".")-1]
	endfunction

	return cursor
endfunction
