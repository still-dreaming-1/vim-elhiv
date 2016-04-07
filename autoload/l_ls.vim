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
	return l:ls
endfunction
