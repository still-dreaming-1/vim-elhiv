UTSuite File when the parent directory is not the root directory

function! s:Setup()
	let s:file= File('/whatever/some.txt')
endfunction

function! s:Test_path()
	AssertEquals('/whatever/some.txt', s:file.path)
endfunction

function! s:Test_name()
	AssertEquals('some.txt', s:file.name)
endfunction

function! s:Test_not_readable()
	Assert !s:file.readable()
endfunction

function! s:Test_extension()
	AssertEquals('txt', s:file.extension)
endfunction
