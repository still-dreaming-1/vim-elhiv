function! L_tags_file(path)
	let tags_file= {}
	let tags_file.path= L_file(a:path).path

	function! tags_file.get_tags(keyword)
		let file= L_file(self.path)
		let tag_list= []
		for pos in file.find_all(a:keyword)
			if pos.x == 0
				let tag= L_tag()
				tag.line_num= pos.y
				add(tag_list, tag)
			endif
		endfor
		return tag_list
	endfunction

	return tags_file
endfunction
