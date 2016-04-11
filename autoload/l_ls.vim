function! l_ls#new(...)
	let l:ls= {}
	if a:0 > 0
		let l:ls.ls= a:1
	else
		let l:ls.ls= []
	endif

	function! l:ls.len()
		return len(self.ls)
	endfunction

	function! l:ls.add(value)
		call add(self.ls, a:value)
	endfunction

	function! l:ls.contains(value)
		for l:value in self.ls
			let l:my_value= { 'value' : l:value }
			let l:other_value= { 'value' : a:value }
			if l:my_value ==# l:other_value
				return 1
			endif
		endfor
		return 0
	endfunction

	return l:ls
endfunction
