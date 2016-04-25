UTSuite Dir_modifying

function! s:Setup()
	let dir= Dir(g:elhiv_dir_path).get_contained_dir('tests/Dir/data')
	Assert dir.exists
	let s:before_dir= dir.get_contained_dir('before')
	Assert !s:before_dir.exists
	call s:before_dir.create_recursive()
	let s:before_dir= Dir(s:before_dir.path)
	Assert s:before_dir.exists
	let s:empty_dir= s:before_dir.get_contained_dir('empty dir')
	Assert !s:empty_dir.exists
	s:empty_dir.create_recursive()
	let s:empty_dir= Dir(s:empty_dir.path)
	Assert s:empty_dir.exists
	let s:after_dir= dir.get_contained_dir('after')
	Assert !s:after_dir.exists
	call s:after_dir.create_recursive()
	let s:after_dir= Dir(s:after_dir.path)
	Assert s:after_dir.exists
endfunction

function! s:Test_copy_empty_dir_and_delete()
	let copy= s:after_dir.get_contained_dir('empty dir')
	Assert !copy.exists
	call s:empty_dir.copy_to(copy)
	let copy= s:after_dir.get_contained_dir('empty dir')
	Assert copy.exists
	call copy.delete()
	let copy= s:after_dir.get_contained_dir('empty dir')
	Assert !copy.exists
endfunction

function! s:Test_create_recursive_no_recursion_and_delete()
	let new_dir= s:after_dir.get_contained_dir('new dir')
	Assert !new_dir.exists
	call new_dir.create_recursive()
	let new_dir= s:after_dir.get_contained_dir('new dir')
	Assert new_dir.exists
	call new_dir.delete()
	let new_dir= s:after_dir.get_contained_dir('new dir')
	Assert !new_dir.exists
endfunction
