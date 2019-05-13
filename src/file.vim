function! L_file(path)
	let file = {}
	let file.path = a:path
	let s_path = L_s(file.path)
	let file.extension = s_path.after_last('.').str
	let file.name = s_path.after_last('/').str
	let file.name_without_extension = L_s(file.name).before_last('.').str

	function! file.readable()
		return l_file_info#new(self.path).readable
	endfunction

	function! file.writable()
		let writable = filewritable(self.path)
		if writable == 1
			return 1
		endif
		return 0
	endfunction

	function! file.create()
		call L_shell().run('touch '.shellescape(self.path))
	endfunction

	function! file.delete()
		call L_shell().run('rm '.shellescape(self.path))
	endfunction

	function! file.copy_to(path)
		call L_shell().run('cp '.shellescape(self.path).' '.shellescape(a:path))
	endfunction

	function! file.edit()
		execute 'e '.fnameescape(self.path)
	endfunction

	function! file.source()
		execute 'source '.fnameescape(self.path)
	endfunction

	function! file.size()
		return getfsize(self.path)
	endfunction

	function! file.append_line(str)
		call writefile([a:str], self.path, 'a')
	endfunction

	" returns a list of lines
	function! file.read_lines()
		return readfile(self.path)
	endfunction

	" searches for all occurances of needle in the file contents. needle is not treated as a regular expression
	function! file.find_all(needle)
		let pos_list = []
		let y = 0
		for line in self.read_lines()
			let start = 0
			let y = y + 1
			let line_len = len(line)
			let x = 0
			while x < line_len
				let x = stridx(line, a:needle, start)
				if x >= 0
					call add(pos_list, L_pos(x + 1, y))
				else
					break
				endif
				let start = x + 1
			endwhile
		endfor
		return pos_list
	endfunction

    function! file.replace_line(number, content_s) abort
        if !self.writable()
            throw 'L_file#replace_line#precondition_failed: this file is not writable'
        endif
        if a:number < 1
            throw 'L_file#replace_line#precondition_failed: number must be greater than 0. number: '. a:number
        endif
        let lines = self.read_lines()
        if len(lines) < a:number
            throw 'L_file#replace_line#precondition_failed: number must be one of the existing lines. number: '
                \ . a:number . ' total lines: ' . len(lines)
        endif
        let line_index = a:number - 1
        if lines[line_index] !=# a:content_s.str
            let lines[line_index] = a:content_s.str
            call writefile(lines, self.path)
            return 1
        endif
        return 0
    endfunction

	return file
endfunction
