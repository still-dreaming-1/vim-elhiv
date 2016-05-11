UTSuite integration non-empty file

function! s:Setup()
	let s:file= Dir(g:elhiv_dir_path).get_contained_dir('tests/static data').get_contained_file('non_empty_php_file.php')
endfunction

function! s:Test_readable()
	Assert s:file.readable()
endfunction

function! s:Test_writable()
	Assert s:file.writable()
endfunction

function! s:Test_not_empty()
	Assert s:file.size() > 0
endfunction
