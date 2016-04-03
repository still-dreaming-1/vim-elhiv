function! l#get_cursor_char()
	return getline(".")[col(".")-1]
endfunction
