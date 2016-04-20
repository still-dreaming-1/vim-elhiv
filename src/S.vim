function! S(str)
	let l:s= {}
	let l:s.str= a:str

	function! l:s.ridx(needle, ...)
		if a:0 > 0
			let l:start= a:1
			return strridx(self.str, a:needle, l:start)
		endif
		return strridx(self.str, a:needle)
	endfunction

	function! l:s.ends_with(str)
		let length= len(a:str)
		if length > len(self.str)
			return 0
		endif
		let s_dic= { 'val' : a:str }
		let my_s_dic= { 'val' : self.str[len(self.str) - len(a:str) : ] }
		return s_dic ==# my_s_dic
	endfunction

	return l:s
endfunction
