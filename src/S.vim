function! S(str)
	let s= {}
	let s.str= a:str
	let s.len= len(s.str)
	
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

	function! s.ends_with(str)
		let length= len(a:str)
		if length > len(self.str)
			return 0
		endif
		let s_dic= { 'val' : a:str }
		let my_s_dic= { 'val' : self.str[ len(self.str) - len(a:str) : ] }
		return s_dic ==# my_s_dic
	endfunction

	function! s.escape(chars)
		return S(escape(self.str, a:chars))
	endfunction

	" returns an S with spaces removed from the beginning and end
	function! s.trim()
		return S(self.str)
	endfunction

	function! s.remove_start()
		return S(self.str)
	endfunction

	return s
endfunction
