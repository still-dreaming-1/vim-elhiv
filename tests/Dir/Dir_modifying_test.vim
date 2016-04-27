UTSuite Dir_modifying

function! s:Setup()
	let dir= Dir(g:elhiv_dir_path).get_contained_dir('tests/Dir/data')
	Assert dir.exists()
	let s:before_dir= dir.get_contained_dir('before')
	Assert !s:before_dir.exists()
	call s:before_dir.create()
	Assert s:before_dir.exists()
	let s:empty_dir= s:before_dir.get_contained_dir('empty dir')
	Assert !s:empty_dir.exists()
	call s:empty_dir.create()
	Assert s:empty_dir.exists()
	let s:after_dir= dir.get_contained_dir('after')
	Assert !s:after_dir.exists()
	call s:after_dir.create()
	Assert s:after_dir.exists()
endfunction

function! s:Teardown()
	let dir= Dir(g:elhiv_dir_path).get_contained_dir('tests/Dir/data')
	Assert dir.exists()
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
