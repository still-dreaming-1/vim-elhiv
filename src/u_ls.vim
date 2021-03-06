" Unique list. The items are guaranteed to be unique, duplicates will not be added.
function! L_u_ls(...)
	let u_ls= { 'ls' : [] }
	let u_ls._ls= L_ls(u_ls.ls)

	function! u_ls.len()
		return self._ls.len()
	endfunction

	function! u_ls.add(value)
		if !self.contains(a:value)
			call self._ls.add(a:value)
		endif
	endfunction

	function! u_ls.extend(list_of_values)
		for value in a:list_of_values
			call self.add(value)
		endfor
	endfunction

	function! u_ls.contains(value)
		return self._ls.contains(a:value)
	endfunction

	if a:0 > 0
		let start_ls= a:1
		for value in start_ls
			call u_ls.add(value)
		endfor
	endif

	return u_ls
endfunction
