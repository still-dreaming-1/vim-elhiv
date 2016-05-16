UTSuite Time

function! s:Test_milliseconds_since_epoch()
	let milli= Time().milliseconds_since_epoch()
	Assert len(milli) > 12
endfunction
