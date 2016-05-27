UTSuite integration test when directory has 1 file with an exension and it has another directory with 1 file with the same extension

function! s:create_script_vars()
	let s:dir= Dir(g:elhiv_dir_path).get_contained_dir('tests/integration/data')
	let s:file= s:dir.get_contained_file('file.js')
	let s:sub_dir= s:dir.get_contained_dir('sub dir')
	let s:sub_file= s:sub_dir.get_contained_file('sub_file.js')
endfunction

function! s:Setup()
	call s:safe_teardown()
	call s:create_script_vars()
	Assert !s:dir.exists()
	call s:dir.create()
	Assert s:dir.exists()
	Assert !s:file.readable()
	Assert !s:file.writable()
	call s:file.create()
	Assert s:file.readable()
	Assert !s:sub_dir.exists()
	call s:sub_dir.create()
	Assert s:sub_dir.exists()
	Assert !s:sub_file.readable()
	Assert !s:sub_file.writable()
	call s:sub_file.create()
	Assert s:sub_file.readable()
endfunction

function! s:safe_teardown()
	call s:create_script_vars()
	call s:dir.delete()
endfunction

function! s:Teardown()
	call s:dir.delete()
	Assert !s:dir.exists()
	Assert !s:file.readable()
	Assert !s:file.writable()
	Assert !s:sub_file.readable()
	Assert !s:sub_file.writable()
endfunction

function! s:Test_contains_1_non_recursive_file()
	let all_files= s:dir.get_all_files()
	AssertEquals(1, len(all_files))
	Assert s:file.path ==# all_files[0].path
endfunction

function! s:Test_contains_2_recursive_files()
	let all_files= s:dir.get_all_files_recursive()
	AssertEquals(2, len(all_files))
	Assert s:file.path ==# all_files[0].path || s:file.path ==# all_files[1].path
	Assert s:sub_file.path ==# all_files[0].path || s:sub_file.path ==# all_files[1].path
endfunction

function! s:Test_2_files_with_js_file_extensions()
	let js_files= s:dir.get_files_with_extension_recursive('js')
	AssertEquals(2, len(js_files))
	Assert js_files[0].path ==# s:file.path || js_files[1].path ==# s:file.path
	Assert js_files[0].path ==# s:sub_file.path || js_files[1].path ==# s:sub_file.path
	AssertDiffers(js_files[0].path, js_files[1].path)
endfunction

function! s:Test_no_files_with_other_file_extensions()
	let php_files= s:dir.get_files_with_extension_recursive('php')
	AssertEquals(0, len(php_files))
	let js_files= s:dir.get_files_with_extension_recursive('txt')
	AssertEquals(0, len(js_files))
endfunction

function! s:Test_contains_1_dir()
	let dirs= s:dir.get_all_dirs()
	AssertEquals(1, len(dirs))
	AssertEquals(s:sub_dir.path, dirs[0].path)

	let dirs= s:dir.get_all_dirs_recursive()
	AssertEquals(1, len(dirs))
	AssertEquals(s:sub_dir.path, dirs[0].path)
endfunction

function! s:Test_files_are_empty()
	AssertEquals(0, s:file.size())
	AssertEquals(0, s:sub_file.size())
	AssertEquals(0, len(s:file.read_lines()))
	AssertEquals(0, len(s:sub_file.read_lines()))
endfunction

function! s:Test_sub_dir_contains_file_path_recursive_for_sub_file()
	Assert s:sub_dir.contains_file_path_recursive(s:sub_file.path)
endfunction

function! s:Test_dir_contains_file_path_recursive_for_sub_file()
	Assert s:dir.contains_file_path_recursive(s:sub_file.path)
endfunction
