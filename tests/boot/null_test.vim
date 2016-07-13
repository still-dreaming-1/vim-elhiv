UTSuite null

function! s:Test_null_equals_null()
	AssertEqual(L_null(), L_null())
endfunction

function! s:Test_null_not_equals_empty_dictionary()
	AssertDiffers(L_null(), {})
endfunction
