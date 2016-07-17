UTSuite integration non-empty file

function! s:Setup()
	let s:static_data_dir= L_dir(g:elhiv_dir_path).get_contained_dir('static test data')
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

function! s:Test_find_all_for_first_char_on_line_1_when_it_is_the_only_instance_of_that_char_in_the_file()
	AssertEquals(s:file.find_all('<'), [L_pos(1, 1)])
endfunction

function! s:Test_find_all_for_char_only_on_line_1()
	AssertEquals(s:file.find_all('?'), [L_pos(2, 1)])
endfunction

function! s:Test_find_all_for_char_only_on_line_2()
	AssertEquals(s:file.find_all('{'), [L_pos(26, 2)])
endfunction

function! s:Test_find_all_for_char_only_on_last_line()
	AssertEquals(s:file.find_all('}'), [L_pos(1, 3)])
endfunction

function! s:Test_find_all_when_found_twice()
	let pos_list= s:file.find_all('s')
	AssertEquals(len(pos_list), 2)
	let pos= pos_list[0]
	AssertEquals(pos.y, 2)
	AssertEquals(pos.x, 4)
	let pos= pos_list[1]
	AssertEquals(pos.y, 2)
	AssertEquals(pos.x, 5)
endfunction
