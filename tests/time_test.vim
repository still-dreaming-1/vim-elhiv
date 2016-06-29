UTSuite time

function! s:Test_milliseconds_since_epoch()
	let milli= L_time().milliseconds_since_epoch()
	Assert len(milli) > 12
endfunction
