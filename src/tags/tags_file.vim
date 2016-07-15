function! L_tags_file(path)
	let tags_file= {}
	let tags_file.path= L_file(a:path).path

	function! tags_file.get_tags(keyword)
		return []
	endfunction

	return tags_file
endfunction
