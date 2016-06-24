UTSuite integration when append_line() twice to file

function! s:Setup()
	let s:dir= L_dir(g:elhiv_dir_path).get_contained_dir('test_data')
	Assert !s:dir.exists()
	call s:dir.create()
	Assert s:dir.exists()
	let s:file= s:dir.get_contained_file('file.txt')
	Assert !s:file.readable()
	Assert !s:file.writable()
	call s:file.create()
	Assert s:file.readable()
	call s:file.append_line('The first line.')
	call s:file.append_line('This is the second line.')
endfunction

function! s:Teardown()
	call s:dir.delete()
	Assert !s:dir.exists()
	Assert !s:file.readable()
	Assert !s:file.writable()
endfunction

function! s:Test_1_file_with_txt_file_extensions()
	let txt_files= s:dir.get_files_with_extension_recursive('txt')
	AssertEquals(1, len(txt_files))
	AssertEquals(s:file.path, txt_files[0].path)
endfunction

function! s:Test_no_files_with_other_file_extensions()
	let php_files= s:dir.get_files_with_extension_recursive('php')
	AssertEquals(0, len(php_files))
	let js_files= s:dir.get_files_with_extension_recursive('js')
	AssertEquals(0, len(js_files))
endfunction

function! s:Test_contains_no_dirs()
	let dirs= s:dir.get_all_dirs()
	AssertEquals(0, len(dirs))
	let dirs= s:dir.get_all_dirs_recursive()
	AssertEquals(0, len(dirs))
endfunction

function! s:Test_file_not_empty()
	Assert 0 < s:file.size()
endfunction

function! s:Test_file_has_the_line()
	let lines= s:file.read_lines()
	AssertEquals(2, len(lines))
	AssertEquals('The first line.', lines[0])
	AssertEquals('This is the second line.', lines[1])
endfunction
