function! L_maps()
	let maps= {}

	function! maps.normal_mode_map_exists_from(str)
		let rhs= maparg(a:str, 'n')
		" let rhs= mapcheck(a:str, 'n')
		if rhs == ''
			return 0
		endif
		return 1
	endfunction

	function! maps.normal_mode_map_exists_to(str)
		let lhs= hasmapto(a:str, 'n')
		if lhs == ''
			return 0
		endif
		return 1
	endfunction

	return maps
endfunction
