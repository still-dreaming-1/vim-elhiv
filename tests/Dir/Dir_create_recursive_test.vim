UTSuite Dir_create_recursive

function! s:Setup()
	let dir= Dir(g:elhiv_dir_path).get_contained_dir('tests/Dir/data')
	let s:before_dir= dir.get_contained_dir('before')
	let s:after_dir= dir.get_contained_dir('after')
endfunction

function! s:Test_create_recursive_no_recursion()
	let new_dir= s:after_dir.get_contained_dir('new_dir')
	AssertDiffers(Null(), new_dir)
	Assert !new_dir.exists
	call new_dir.create_recursive()
	let new_dir= s:after_dir.get_contained_dir('new_dir')
	Assert new_dir.exists
	call new_dir.delete()
endfunction
