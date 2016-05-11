UTSuite integration non-empty file

function! s:Setup()
	let s:static_data_dir= Dir(g:elhiv_dir_path).get_contained_dir('tests/static data')
	let s:file= s:static_data_dir.get_contained_file('non_empty_php_file.php')
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

function! s:Test_parent_dir_contains_file_path_recursive()
	Assert s:static_data_dir.contains_file_path_recursive(s:file.path)
endfunction
