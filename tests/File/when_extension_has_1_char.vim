UTSuite File when extension has 1 character

function! s:Setup()
	let s:file= File('/yay/I have an extension.c')
endfunction

function! s:Test_path()
	AssertEquals('/yay/I have an extension.c', s:file.path)
endfunction

function! s:Test_name()
	AssertEquals('I have an extension.c', s:file.name)
endfunction

function! s:Test_not_readable()
	Assert !s:file.readable()
endfunction

function! s:Test_extension()
	AssertEquals('c', s:file.extension)
endfunction
