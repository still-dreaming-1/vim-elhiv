UTSuite integration non-empty file

function! s:Setup()
	let s:static_data_dir= Dir(g:elhiv_dir_path).get_contained_dir('static test data')
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
	Assert 0 < len(s:file.read_lines())
endfunction

function! s:Test_contains_the_lines()
	let lines= s:file.read_lines()
	AssertEquals('<?', lines[0])
	AssertEquals('class non_empty_php_file {', lines[1])
	AssertEquals('}', lines[2])
endfunction

function! s:Test_parent_dir_contains_file_path_recursive()
	Assert s:static_data_dir.contains_file_path_recursive(s:file.path)
endfunction
