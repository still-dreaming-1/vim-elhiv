function! l_s#new(str)
	let s= {}
	let s.str= a:str
	let s.len= len(s.str)

	function! s.ridx(needle, ...)
		if a:0 > 0
			let start= a:1
			return strridx(self.str, a:needle, start)
		endif
		return strridx(self.str, a:needle)
	endfunction

	function! s.starts_with(str)
		let length= len(a:str)
		if length > len(self.str)
			return 0
		endif
		let s_dic= { 'val' : a:str }
		let my_s_dic= { 'val' : self.str[ 0 : len(a:str) - 1 ] }
		return s_dic ==# my_s_dic
	endfunction

	function! s.remove_end()
		if self.len <= 1
			return l_s#new('')
		endif
		return l_s#new(self.str[0 : self.len - 2])
	endfunction

	return s
endfunction
