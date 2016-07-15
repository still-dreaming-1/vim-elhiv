UTSuite integration: when empty tags file

function! s:setup_script_vars()
	let s:data_dir= g:elhiv_dir.get_contained_dir('test data')
	let s:empty_tags_file= L_tags_file(s:data_dir.get_contained_file('empty tags file').path)
endfunction

function! s:Setup()
	call s:safe_teardown()
	call s:setup_script_vars()
	call s:data_dir.create()
	Assert s:data_dir.exists()
	let file= L_file(s:empty_tags_file.path)
	Assert !file.readable()
	Assert !file.writable()
	call file.create()
	Assert file.readable()
	Assert file.writable()
	AssertEquals(file.size(), 0)
endfunction

function! s:safe_teardown()
	call s:setup_script_vars()
	call s:data_dir.delete()
endfunction

function! s:Teardown()
	call s:setup_script_vars()
	call s:data_dir.delete()
	Assert! !s:data_dir.exists()
endfunction

function! s:test_it_has_no_tags()
	let tag_list= s:empty_tags_file.get_tags('Teardown')
	AssertEquals(len(tag_list), 0)
endfunction
