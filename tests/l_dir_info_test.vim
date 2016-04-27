UTSuite l_dir_info

function! s:create_script_vars()
	let s:data_dir= Dir(g:elhiv_dir_path).get_contained_dir('tests/Dir/data')
	let s:before_dir= s:data_dir.get_contained_dir('before')
	let s:empty_dir= s:before_dir.get_contained_dir('empty dir')
	let s:dir_with_1_file= s:before_dir.get_contained_dir('dir with 1 file')
	let s:after_dir= s:data_dir.get_contained_dir('after')
endfunction

function! s:Setup()
	call s:safe_tear_down()
	call s:create_script_vars()
	Assert s:data_dir.exists()
	Assert !s:before_dir.exists()
	call s:before_dir.create()
	Assert s:before_dir.exists()
	Assert !s:empty_dir.exists()
	call s:empty_dir.create()
	Assert s:empty_dir.exists()
	Assert !s:dir_with_1_file.exists()
	call s:dir_with_1_file.create()
	Assert s:dir_with_1_file.exists()
	let file= s:dir_with_1_file.get_contained_file('file')
	Assert !file.readable()
	call file.create()
	Assert file.readable()
	Assert !s:after_dir.exists()
	call s:after_dir.create()
	Assert s:after_dir.exists()
endfunction

function! s:Teardown()
	call s:create_script_vars()
	Assert s:data_dir.exists()
	Assert s:before_dir.exists()
	call s:before_dir.delete()
	Assert !s:before_dir.exists()

	Assert s:after_dir.exists()
	call s:after_dir.delete()
	Assert !s:after_dir.exists()
endfunction

function! s:safe_tear_down()
	call s:create_script_vars()
	if s:before_dir.exists()
		call s:before_dir.delete()
	endif
	if s:after_dir.exists()
		call s:after_dir.delete()
	endif
endfunction

function! s:Test_get_all_file_info_when_empty_dir()
	let empty_dir_info= l_dir_info#new(s:empty_dir.path)
	let all_file_info= empty_dir_info.get_all_file_info()
	AssertEquals([], all_file_info)
endfunction

function! s:Test_get_all_file_info_when_contains_one_file()
	let dir_info= l_dir_info#new(s:dir_with_1_file.path)
	let all_file_info= dir_info.get_all_file_info()
	" this is the expected output from the shell command that ran in that method:
	" /home/jesse/.config/nvim/plugged/vim-elhiv/tests/Dir/data/before/dir with 1 file/file
	" there could also be more lines with more files below that in the output
	AssertEquals(1, len(all_file_info))
endfunction
