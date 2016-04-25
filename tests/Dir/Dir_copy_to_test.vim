UTSuite Dir_copy_to

function! s:Setup()
	let dir= Dir(g:elhiv_dir_path).get_contained_dir('tests/Dir/data')
	let s:before_dir= dir.get_contained_dir('before')
	let s:after_dir= dir.get_contained_dir('after')
endfunction

function! s:Test_copy_empty_dir()
	let dir= s:before_dir.get_contained_dir('empty_dir')
	Assert dir.exists
	let copy= s:after_dir.get_contained_dir('empty_dir')
	Assert! copy.exists
	call dir.copy_to(copy)
	let copy= s:after_dir.get_contained_dir('empty_dir')
	Assert copy.exists
endfunction
