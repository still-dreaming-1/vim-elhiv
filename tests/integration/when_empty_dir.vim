UTSuite integration: when empty dir

function! s:Setup()
	let s:empty_dir= Dir(g:elhiv_dir_path).get_contained_dir('static test data/empty dir')
	Assert s:empty_dir.exists()
	let s:non_existent_file= s:empty_dir.get_contained_file('non existent file.txt')
endfunction

function! s:Test_non_existent_file_not_readable()
	Assert !s:non_existent_file.readable()
endfunction

function! s:Test_non_existent_file_not_writable()
	Assert !s:non_existent_file.writable()
endfunction

function! s:Test_parent_dir_not_contains_file_path_recursive()
	Assert !s:empty_dir.contains_file_path_recursive(s:non_existent_file.path)
endfunction
