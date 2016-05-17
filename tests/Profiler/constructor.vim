UTSuite Profiler constructor

function! s:Setup()
	let s:profiler= Profiler()
endfunction

function! s:Test_is_dictionary()
	AssertEquals(4, type(s:profiler))
endfunction

function! s:Test_not_null()
	AssertDiffers(Null(), s:profiler)
endfunction
