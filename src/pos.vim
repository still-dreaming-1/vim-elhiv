function! L_pos(...)
	let pos= {}

	let pos.x= 0
	let pos.y= 0
	if a:0 > 0
		let pos.x= a:1
	endif
	if a:0 > 1
		let pos.y= a:2
	endif

	return pos
endfunction
