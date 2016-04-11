function! l_u_ls#new(...)
	let l:u_ls= { 'ls' : [] }
	let l:u_ls._ls= l_ls#new(l:u_ls.ls)

	function! l:u_ls.len()
		return self._ls.len()
	endfunction

	function! l:u_ls.add(value)
		if !self.contains(a:value)
			call self._ls.add(a:value)
		endif
	endfunction

	function! l:u_ls.contains(value)
		return self._ls.contains(a:value)
	endfunction

	if a:0 > 0
		let l:start_ls= a:1
		for l:value in l:start_ls
			call l:u_ls.add(l:value)
		endfor
	endif

	return l:u_ls
endfunction
