UTSuite integration test when directory has 2 files with the same file extension

function! s:Setup()
	let s:dir= Dir(g:elhiv_dir_path).get_contained_dir('tests/integration/data')
	Assert !s:dir.exists()
	call s:dir.create()
	Assert s:dir.exists()
	let s:file= s:dir.get_contained_file('file.js')
	Assert !s:file.readable()
	Assert !s:file.writable()
	call s:file.create()
	Assert s:file.readable()
	let s:second_file= s:dir.get_contained_file('second_file.js')
	Assert !s:second_file.readable()
	Assert !s:second_file.writable()
	call s:second_file.create()
	Assert s:second_file.readable()
endfunction

function! s:Teardown()
	call s:dir.delete()
	Assert !s:dir.exists()
	Assert !s:file.readable()
	Assert !s:file.writable()
	Assert !s:second_file.readable()
	Assert !s:second_file.writable()
endfunction

function! s:Test_2_files_with_js_file_extensions()
	let js_files= s:dir.get_files_with_extension_recursive('js')
	AssertEquals(2, len(js_files))
	Assert js_files[0].path ==# s:file.path || js_files[1].path ==# s:file.path
	Assert js_files[0].path ==# s:second_file.path || js_files[1].path ==# s:second_file.path
	AssertDiffers(js_files[0].path, js_files[1].path)
endfunction

function! s:Test_no_files_with_other_file_extensions()
	let php_files= s:dir.get_files_with_extension_recursive('php')
	AssertEquals(0, len(php_files))
	let js_files= s:dir.get_files_with_extension_recursive('txt')
	AssertEquals(0, len(js_files))
endfunction

function! s:Test_contains_no_dirs()
	let dirs= s:dir.get_all_dirs()
	AssertEquals(0, len(dirs))

	let dirs= s:dir.get_all_dirs_recursive()
	AssertEquals(0, len(dirs))
endfunction

function! s:Test_files_are_empty()
	AssertEquals(0, s:file.size())
	AssertEquals(0, s:second_file.size())
	AssertEquals(0, len(s:file.read_lines()))
	AssertEquals(0, len(s:second_file.read_lines()))
endfunction
