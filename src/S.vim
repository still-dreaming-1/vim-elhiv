function! S(str)
	let s= {}
	let s.str= a:str
	let s.len= len(s.str)

	function! s.contains(needle)
		return stridx(self.str, a:needle) != -1
	endfunction
	
	" returns -1 or index
	function! s.ridx(needle, ...)
		if a:0 > 0
			let start= a:1
			return l_s#new(self.str).ridx(a:needle, start)
		endif
		return l_s#new(self.str).ridx(a:needle)
	endfunction

	function! s.starts_with(str)
		return l_s#new(self.str).starts_with(a:str)
	endfunction

	function! s.remove_end()
		return S(l_s#new(self.str).remove_end().str)
	endfunction

	function! s.ends_with(needle)
		let needle_length= len(a:needle)
		let my_length= len(self.str)
		if needle_length > my_length
			return 0
		endif
		return a:needle ==# self.str[ my_length - needle_length : ]
	endfunction

	function! s.escape(chars)
		return S(escape(self.str, a:chars))
	endfunction

	" returns an S with spaces and \n removed from the beginning and end
	function! s.trim()
		let ret_s= S(self.str)
		let chars_to_trim= [' ', "\n"]
		for char in chars_to_trim
			while ret_s.starts_with(char)
				let ret_s= ret_s.remove_start()
			endwhile
			while ret_s.ends_with(char)
				let ret_s= ret_s.remove_end()
			endwhile
		endfor
		return ret_s
	endfunction

	function! s.remove_start()
		return S(self.str[1 : ])
	endfunction

	function! s.after_last(str)
		let i= self.ridx(a:str)
		if i == -1
			return S('')
		endif
		return S(self.str[i + len(a:str) : ])
	endfunction

	function! s.before_last(str)
		let i= self.ridx(a:str)
		if i == -1
			return S(self.str)
		endif
		let i -= 1
		if i <= 0
			return S('')
		endif
		return S(self.str[0 : i])
	endfunction

	return s
endfunction
