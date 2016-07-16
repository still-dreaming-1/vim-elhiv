UTSuite integration empty txt file

function! s:Setup()
	let s:static_data_dir= L_dir(g:elhiv_dir_path).get_contained_dir('static test data')
	let s:file= s:static_data_dir.get_contained_file('empty file.txt')
endfunction

function! s:Test_readable()
	Assert s:file.readable()
endfunction

function! s:Test_writable()
	Assert s:file.writable()
endfunction

function! s:Test_empty()
	AssertEquals(s:file.size(), 0)
	AssertEquals(len(s:file.read_lines()), 0)
endfunction

function! s:Test_cant_find_stuff()
	AssertEquals(s:file.find_all('class'), [])
endfunction

function! s:Test_parent_dir_contains_file_path_recursive()
	Assert s:static_data_dir.contains_file_path_recursive(s:file.path)
endfunction
