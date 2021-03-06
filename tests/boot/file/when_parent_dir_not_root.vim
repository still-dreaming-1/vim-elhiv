UTSuite L_file when the parent directory is not the root directory

function! s:Setup()
	let s:file= L_file('/whatever/some.txt')
endfunction

function! s:Test_path()
	AssertEquals('/whatever/some.txt', s:file.path)
endfunction

function! s:Test_name()
	AssertEquals('some.txt', s:file.name)
endfunction

function! s:Test_name_without_extension()
	AssertEquals('some', s:file.name_without_extension)
endfunction

function! s:Test_not_readable()
	Assert !s:file.readable()
endfunction

function! s:Test_extension()
	AssertEquals('txt', s:file.extension)
endfunction
