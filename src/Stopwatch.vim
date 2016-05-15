function! Stopwatch()
	let stopwatch= {}
	let stopwatch.start_time= -1
	let stopwatch.stop_time= -1
	let stopwatch.elapsed_milliseconds= -1

	function! stopwatch.start()
		let self.start_time= self._milliseconds_since_epoch()
	endfunction

	function! stopwatch.stop()
		let self.stop_time= self._milliseconds_since_epoch()
		" even though self.stop_time and self.start_time are strings that are too large to be a number, self.elapsed_milliseconds will be accurate and will be a number type:
		let self.elapsed_milliseconds= self.stop_time - self.start_time 
		return self.elapsed_milliseconds
	endfunction

	" returns a string. This is better than returning a number because it is too large to return as a number
	function! stopwatch._milliseconds_since_epoch()
		return Shell().run('echo $(($(date +%s%N)/1000000))')
	endfunction

	return stopwatch
endfunction
