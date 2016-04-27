UTSuite File

function! s:Test_path()
	AssertEquals('/home/some.file', File('/home/some.file').path)
endfunction

function! s:Test_non_existent_file_not_readable()
	let file= File('/home/i_am_pretty_sure_this_file_exists.not')
	Assert !file.readable()
endfunction
