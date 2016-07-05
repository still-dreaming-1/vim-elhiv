UTSuite dir modifying

function! s:setup_script_vars()
	let s:data_dir= L_dir(g:elhiv_dir_path).get_contained_dir('tests/dir/data')
		let s:before_dir= s:data_dir.get_contained_dir('before')
			let s:empty_dir= s:before_dir.get_contained_dir('empty dir')
		let s:after_dir= s:data_dir.get_contained_dir('after')
endfunction

function! s:Setup()
	call s:safe_teardown()
	call s:setup_script_vars()
	Assert s:data_dir.exists()
	Assert !s:before_dir.exists()
	call s:before_dir.create()
	Assert s:before_dir.exists()
	Assert !s:empty_dir.exists()
	call s:empty_dir.create()
	Assert s:empty_dir.exists()
	Assert !s:after_dir.exists()
	call s:after_dir.create()
	Assert s:after_dir.exists()
endfunction

function! s:safe_teardown()
	call s:setup_script_vars()
	Assert s:data_dir.exists()
	if s:before_dir.exists()
		call s:before_dir.delete()
	endif
	if s:after_dir.exists()
		call s:after_dir.delete()
	endif
endfunction

function! s:Teardown()
	call s:setup_script_vars()
	Assert s:data_dir.exists()
	Assert s:before_dir.exists()
	call s:before_dir.delete()
	Assert !s:before_dir.exists()

	Assert s:after_dir.exists()
	call s:after_dir.delete()
	Assert !s:after_dir.exists()
endfunction

function! s:Test_copy_empty_dir_and_delete()
	let copy= s:after_dir.get_contained_dir('empty dir')
	Assert !copy.exists()
	call s:empty_dir.copy_to(copy)
	Assert copy.exists()
	AssertEquals(0, len(copy.get_all_files()))
	call copy.delete()
	Assert !copy.exists()
endfunction

function! s:Test_create_no_recursion_and_delete()
	let new_dir= s:after_dir.get_contained_dir('new dir')
	Assert !new_dir.exists()
	call new_dir.create()
	Assert new_dir.exists()
	call new_dir.delete()
	Assert !new_dir.exists()
endfunction

function! s:Test_get_all_files_when_1_file()
	let files= s:data_dir.get_all_files()
	AssertEquals(1, len(files))
	let gitignore= files[0]
	Assert gitignore.readable()
	Assert L_s(gitignore.path).ends_with('.gitignore')
endfunction

function! s:Test_get_all_files_when_2_files()
	let expected_first_file= s:after_dir.get_contained_file('first file')
	call expected_first_file.create()
	let expected_second_file= s:after_dir.get_contained_file('second file')
	call expected_second_file.create()
	let all_files= s:after_dir.get_all_files()
	AssertEquals(2, len(all_files))
	let actual_first_file= all_files[0]
	Assert actual_first_file.readable()
	Assert L_s(actual_first_file.path).ends_with('first file')
	let actual_second_file= all_files[1]
	Assert actual_second_file.readable()
	Assert L_s(actual_second_file.path).ends_with('second file')
endfunction
