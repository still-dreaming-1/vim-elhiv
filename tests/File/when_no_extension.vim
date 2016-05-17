UTSuite File when extension has 3 characters

function! s:Setup()
	let s:file= File('/whatever/some')
endfunction

function! s:Test_path()
	AssertEquals('/whatever/some', s:file.path)
endfunction

function! s:Test_name()
	AssertEquals('some', s:file.name)
endfunction

function! s:Test_name_without_extension()
	AssertEquals('some', s:file.name_without_extension)
endfunction

function! s:Test_not_readable()
	Assert !s:file.readable()
endfunction

function! s:Test_extension()
	AssertEquals('', s:file.extension)
endfunction
