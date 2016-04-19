UTSuite File

function! s:Test_path()
	AssertEquals('/home/some_file', File('/home/some_file').path)
endfunction
