UTSuite File when 2 parent directories before the root directory

function! s:Setup()
	let s:file= File('/ok/whatever/some.txt')
endfunction

function! s:Test_path()
	AssertEquals('/ok/whatever/some.txt', s:file.path)
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
