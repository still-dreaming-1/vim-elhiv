UTSuite stopwatch tests

function! s:Test_stopwatch()
	let stopwatch= L_stopwatch()
	call stopwatch.start()
	let elapsed_milliseconds= stopwatch.stop()
	AssertEquals(elapsed_milliseconds, stopwatch.elapsed_milliseconds)
	Assert stopwatch.start_time <= stopwatch.stop_time
endfunction
