UTSuite Dir_modifying

function! s:Setup()
	let dir= Dir(g:elhiv_dir_path).get_contained_dir('tests/Dir/data')
	let s:before_dir= dir.get_contained_dir('before')
	let s:after_dir= dir.get_contained_dir('after')
endfunction

" function! s:Test_copy_empty_dir()
" 	let dir= s:before_dir.get_contained_dir('empty_dir')
" 	Assert dir.exists
" 	let copy= s:after_dir.get_contained_dir('empty_dir')
" 	Assert !copy.exists
" 	call dir.copy_to(copy)
" 	let copy= s:after_dir.get_contained_dir('empty_dir')
" 	Assert copy.exists
" endfunction

function! s:Test_create_recursive_no_recursion_and_delete()
	let new_dir= s:after_dir.get_contained_dir('new_dir')
	AssertDiffers(Null(), new_dir)
	Assert !new_dir.exists
	call new_dir.create_recursive()
	let new_dir= s:after_dir.get_contained_dir('new_dir')
	Assert new_dir.exists
	call new_dir.delete()
	let new_dir= s:after_dir.get_contained_dir('new_dir')
	Assert !new_dir.exists
endfunction
