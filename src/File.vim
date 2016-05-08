function! File(path)
	let file= {}
	let file.path= a:path
	let file.extension= ''
	let ext_start_i= S(file.path).ridx('.')
	if ext_start_i != -1
		let ext_start_i += 1
		if len(file.path) > ext_start_i
			let file.extension= file.path[ext_start_i : ]
		endif
	endif

	function! file.readable()
		return l_file_info#new(self.path).readable
	endfunction

	function! file.writable()
		let writable= filewritable(self.path)
		if writable == 1
			return 1
		endif
		return 0
	endfunction

	function! file.create()
		call Shell().run('touch '.shellescape(self.path))
	endfunction

	function! file.delete()
		call Shell().run('rm '.shellescape(self.path))
	endfunction

	function! file.copy_to(path)
		call Shell().run('cp '.shellescape(self.path).' '.shellescape(a:path))
	endfunction

	function! file.edit()
		execute "e ".fnameescape(self.path)
	endfunction

	function! file.source()
		execute "source ".fnameescape(self.path)
	endfunction

	return file
endfunction
