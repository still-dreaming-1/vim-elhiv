UTSuite tag

function! s:test_something()
	let tag= L_tag()
	AssertEquals(tag.path, '')
endfunction
