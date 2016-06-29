function! Time()
	let time= {}
	
	" returns a string. This is better than returning a number because it is too large to return as a number
	function! time.milliseconds_since_epoch()
		let milliseconds= Shell().run('echo $(($(date +%s%N)/1000000))')
		return L_s(milliseconds).trim().str
	endfunction

	return time
endfunction
