UTSuite integration when directory has one file with no file extension

function! s:Setup()
	let s:dir= L_dir(g:elhiv_dir_path).get_contained_dir('tests/boot/integration/data')
	Assert !s:dir.exists()
	call s:dir.create()
	Assert s:dir.exists()
	let s:file= s:dir.get_contained_file('file')
	Assert !s:file.readable()
	Assert !s:file.writable()
	call s:file.create()
	Assert s:file.readable()
endfunction

function! s:Teardown()
	call s:dir.delete()
	Assert !s:dir.exists()
	Assert !s:file.readable()
	Assert !s:file.writable()
endfunction

function! s:Test_copy_and_delete()
	let file_copy= s:dir.get_contained_file('file copy')
	Assert !file_copy.readable()
	call s:file.copy_to(file_copy.path)
	Assert file_copy.readable()
	call file_copy.delete()
	Assert !file_copy.readable()
endfunction

function! s:Test_no_files_with_file_extensions()
	let txt_files= s:dir.get_files_with_extension_recursive('txt')
	AssertEquals(0, len(txt_files))
	let php_files= s:dir.get_files_with_extension_recursive('php')
	AssertEquals(0, len(php_files))
	let js_files= s:dir.get_files_with_extension_recursive('js')
	AssertEquals(0, len(js_files))
endfunction

function! s:Test_no_matching_file_extension_when_missing_dot()
	let files= s:dir.get_files_with_extension_recursive('ile')
	AssertEquals(0, len(files))
endfunction

function! s:Test_contains_no_dirs()
	let dirs= s:dir.get_all_dirs()
	AssertEquals(0, len(dirs))
	let dirs= s:dir.get_all_dirs_recursive()
	AssertEquals(0, len(dirs))
endfunction

function! s:Test_file_is_empty()
	AssertEquals(0, s:file.size())
	AssertEquals(0, len(s:file.read_lines()))
endfunction
