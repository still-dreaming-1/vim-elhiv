function! Time()
	let time= {}
	
	" returns a string. This is better than returning a number because it is too large to return as a number
	function! time.milliseconds_since_epoch()
		return Shell().run('echo $(($(date +%s%N)/1000000))')
	endfunction
	return time
endfunction
