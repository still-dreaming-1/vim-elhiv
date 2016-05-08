UTSuite File

function! s:Test_path()
	AssertEquals('/home/some.file', File('/home/some.file').path)
endfunction

function! s:Test_non_existent_file_not_readable()
	let file= File('/home/i_am_pretty_sure_this_file_exists.not')
	Assert !file.readable()
endfunction

function! s:Test_extension_when_has_extension_3_chars()
	let file= File('I have an extension.txt')
	AssertEquals('txt', file.extension)
endfunction

function! s:Test_extension_when_has_extension_2_chars()
	let file= File('I have an extension.js')
	AssertEquals('js', file.extension)
endfunction

function! s:Test_extension_when_has_extension_1_chars()
	let file= File('I have an extension.c')
	AssertEquals('c', file.extension)
endfunction

function! s:Test_extension_is_empty_when_no_extension()
	let file= File('I do not have an extension')
	AssertEquals('', file.extension)
endfunction

function! s:Test_extension_is_empty_when_no_extension_and_ends_with_dot()
	let file= File('I do not have an extension.')
	AssertEquals('', file.extension)
endfunction
