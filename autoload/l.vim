function! l#get_cursor_char()
	return getline(".")[col(".")-1]
endfunction

function! l#null()
	return { 'isnull' : 1 }
endfunction
