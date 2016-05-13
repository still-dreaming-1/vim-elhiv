function! Stopwatch()
	let stopwatch= {}
	let stopwatch.start_time= -1
	let stopwatch.stop_time= -1
	let stopwatch.elapsed_milliseconds= -1

	function! stopwatch.start()
		" this might be a useful function here: reltime()
		let self.start_time= -1
	endfunction

	function! stopwatch.stop()
		let self.stop_time= -1
		let self.elapsed_milliseconds= self.stop_time - self.start_time
		return self.elapsed_milliseconds
	endfunction

	return stopwatch
endfunction
