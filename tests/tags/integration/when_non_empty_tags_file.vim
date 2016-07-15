UTSuite integration: when non-empty tags file

function! s:setup_script_vars()
	let s:static_data_dir= g:elhiv_dir.get_contained_dir('static test data')
		let s:static_tags_file_file= s:static_data_dir.get_contained_file('non empty tags file')
		let s:static_tags_file= L_tags_file(s:static_tags_file_file.path)
endfunction

function! s:Setup()
	call s:setup_script_vars()
	Assert! s:static_tags_file_file.readable()
	Assert! s:static_tags_file_file.size() > 0
endfunction

function! s:test_it_does_not_contain_non_existent_tags()
	let tag_list= s:static_tags_file.get_tags('garbledeygoop')
	AssertEquals(len(tag_list), 0)
endfunction

function! s:test_it_contains_existing_tag_once()
	let tag_list= s:static_tags_file.get_tags('Test_0_ends_with_0')
	AssertEquals(len(tag_list), 1)
endfunction
