UTSuite Time

function! s:Test_milliseconds_since_epoch()
	let milli= Time().milliseconds_since_epoch()
	" an example of something that milli might be set to:
	" 1463354198801
	Assert 12 < len(milli)
endfunction
