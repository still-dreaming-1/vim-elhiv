UTSuite Stopwatch tests

function! s:Test_Stopwatch()
	let stopwatch= Stopwatch()
	call stopwatch.start()
	let elapsed_milliseconds= stopwatch.stop()
	AssertEquals(elapsed_milliseconds, stopwatch.elapsed_milliseconds)
	Assert stopwatch.start_time <= stopwatch.stop_time
endfunction
