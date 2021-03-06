function! L_tags_file(path)
	let tags_file= {}
	let tags_file.path= L_file(a:path).path

	function! tags_file.get_tags(keyword)
		let file= L_file(self.path)
		let tag_list= []
		for pos in file.find_all(a:keyword.'	') " appending tab delimiter
			if pos.x == 1
				let tag= L_tag()
				let tag.line_num= pos.y
				call add(tag_list, tag)
			endif
		endfor
		return tag_list
	endfunction

	return tags_file
endfunction
