function! S(str)
	let s= l_s#new(a:str)

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
		return escape(self.str, a:chars)
	endfunction

	return s
endfunction
