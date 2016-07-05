UTSuite dir modifying

function! s:setup_script_vars()
	let s:static_data_dir= L_dir(g:elhiv_dir_path).get_contained_dir('static test data')
		let s:static_empty_dir= s:static_data_dir.get_contained_dir('empty dir')
	let s:data_dir= L_dir(g:elhiv_dir_path).get_contained_dir('test_data')
		let s:after_dir= s:data_dir.get_contained_dir('after')
endfunction

function! s:Setup()
	call s:safe_teardown()
	call s:setup_script_vars()
	Assert! s:static_data_dir.exists()
		Assert! s:static_empty_dir.exists()
	Assert! !s:data_dir.exists()
	call s:data_dir.create()
		Assert! !s:after_dir.exists()
		call s:after_dir.create()
		Assert! s:after_dir.exists()
endfunction

function! s:safe_teardown()
	call s:setup_script_vars()
	if s:data_dir.exists()
		call s:data_dir.delete()
	endif
endfunction

function! s:Teardown()
	call s:setup_script_vars()
	Assert s:data_dir.exists()
	call s:data_dir.delete()
endfunction

function! s:Test_copy_empty_dir_and_delete()
	let copy= s:data_dir.get_contained_dir('empty dir')
	Assert !copy.exists()
	call s:static_empty_dir.copy_to(copy)
	Assert copy.exists()
	AssertEquals(0, len(copy.get_all_files()))
	call copy.delete()
	Assert !copy.exists()
	Assert! s:static_empty_dir.exists()
endfunction

function! s:Test_create_no_recursion_and_delete()
	let new_dir= s:data_dir.get_contained_dir('new dir')
	Assert !new_dir.exists()
	call new_dir.create()
	Assert new_dir.exists()
	call new_dir.delete()
	Assert !new_dir.exists()
	Assert! s:data_dir.exists()
endfunction

function! s:Test_get_all_files_when_1_file()
	let file= s:data_dir.get_contained_file('file')
	Assert !file.readable()
	Assert !file.writable()
	call file.create()
	Assert file.readable()
	let file_list= s:data_dir.get_all_files()
	AssertEquals(1, len(file_list))
	let same_file= file_list[0]
	Assert L_s(same_file.path).ends_with('file')
	AssertEquals(same_file.path, file.path)
endfunction

function! s:Test_get_all_files_when_2_files()
	let expected_first_file= s:data_dir.get_contained_file('first file')
	call expected_first_file.create()
	let expected_second_file= s:data_dir.get_contained_file('second file')
	call expected_second_file.create()
	let all_files= s:data_dir.get_all_files()
	AssertEquals(2, len(all_files))
	let actual_first_file= all_files[0]
	Assert actual_first_file.readable()
	Assert L_s(actual_first_file.path).ends_with('first file')
	let actual_second_file= all_files[1]
	Assert actual_second_file.readable()
	Assert L_s(actual_second_file.path).ends_with('second file')
endfunction
