function! l_s#new()
	let l:s= {}

	function! l:s.ridx(haystack, needle, ...)
		if a:0 > 0
			let l:start= a:1
			return strridx(a:haystack, a:needle, l:start)
		endif
		return strridx(a:haystack, a:needle)
	endfunction
	return l:s
endfunction
