UTSuite modifying test when directory has 1 file with an exension it has another directory with 1 file with the same extension

function! s:Setup()
	let s:dir= Dir(g:elhiv_dir_path).get_contained_dir('tests/modifying/data')
	Assert !s:dir.exists()
	call s:dir.create()
	Assert s:dir.exists()
	let s:file= s:dir.get_contained_file('file.js')
	Assert !s:file.readable()
	Assert !s:file.writable()
	call s:file.create()
	Assert s:file.readable()
	let s:sub_dir= s:dir.get_contained_dir('sub dir')
	Assert !s:sub_dir.exists()
	call s:sub_dir.create()
	Assert s:sub_dir.exists()
	let s:sub_file= s:sub_dir.get_contained_file('sub_file.js')
	Assert !s:sub_file.readable()
	Assert !s:sub_file.writable()
	call s:sub_file.create()
	Assert s:sub_file.readable()
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
	Assert s:second_file.path ==# all_files[0].path || s:second_file.path ==# all_files[1].path
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
