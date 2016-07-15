function! L_tag()
	let tag= {}
	let tag.tags_file_line_num= -1
	let tag.path= ''
	let tag.line_num= -1

	function! tag.some_method()
	endfunction

	return tag
endfunction
