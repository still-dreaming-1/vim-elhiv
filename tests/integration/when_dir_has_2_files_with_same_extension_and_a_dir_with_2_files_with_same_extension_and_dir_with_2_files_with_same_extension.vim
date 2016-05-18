UTSuite integration test when directory has 2 files with the same extension and a directory with 2 files with the same extension and a directory with 2 files with the same extension

function! s:create_script_vars()
	let s:dir= Dir(g:elhiv_dir_path).get_contained_dir('tests/integration/data')
	let s:file= s:dir.get_contained_file('file.js')
	let s:file_2= s:dir.get_contained_file('file_2.js')
	let s:sub_dir= s:dir.get_contained_dir('sub dir')
	let s:sub_file= s:sub_dir.get_contained_file('sub_file.js')
	let s:sub_file_2= s:sub_dir.get_contained_file('sub_file_2.js')
	let s:sub_sub_dir= s:sub_dir.get_contained_dir('sub sub dir')
	let s:sub_sub_file= s:sub_sub_dir.get_contained_file('sub_sub_file.js')
	let s:sub_sub_file_2= s:sub_sub_dir.get_contained_file('sub_sub_file_2.js')
endfunction

function! s:Setup()
	let s:stopwatch= Stopwatch()
	call s:stopwatch.start()
	call s:safe_teardown()
	call s:create_script_vars()
	Assert !s:dir.exists()
	call s:dir.create()
	Assert s:dir.exists()
	Assert !s:file.readable()
	Assert !s:file.writable()
	call s:file.create()
	Assert s:file.readable()
	Assert s:file.writable()
	Assert !s:file_2.readable()
	Assert !s:file_2.writable()
	call s:file_2.create()
	Assert s:file_2.readable()
	Assert s:file_2.writable()
	Assert !s:sub_dir.exists()
	call s:sub_dir.create()
	Assert s:sub_dir.exists()
	Assert !s:sub_file.readable()
	Assert !s:sub_file.writable()
	call s:sub_file.create()
	Assert s:sub_file.readable()
	Assert s:sub_file.writable()
	Assert !s:sub_file_2.readable()
	Assert !s:sub_file_2.writable()
	call s:sub_file_2.create()
	Assert s:sub_file_2.readable()
	Assert s:sub_file_2.writable()
	Assert !s:sub_sub_dir.exists()
	call s:sub_sub_dir.create()
	Assert s:sub_sub_dir.exists()
	Assert !s:sub_sub_file.readable()
	Assert !s:sub_sub_file.writable()
	call s:sub_sub_file.create()
	Assert s:sub_sub_file.readable()
	Assert s:sub_sub_file.writable()
	Assert !s:sub_sub_file_2.readable()
	Assert !s:sub_sub_file_2.writable()
	call s:sub_sub_file_2.create()
	Assert s:sub_sub_file_2.readable()
	Assert s:sub_sub_file_2.writable()
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
	Assert !s:file_2.readable()
	Assert !s:file_2.writable()
	Assert !s:sub_dir.exists()
	Assert !s:sub_file.readable()
	Assert !s:sub_file.writable()
	Assert !s:sub_file_2.readable()
	Assert !s:sub_file_2.writable()
	Assert !s:sub_sub_dir.exists()
	Assert !s:sub_sub_file.readable()
	Assert !s:sub_sub_file.writable()
	Assert !s:sub_sub_file_2.readable()
	Assert !s:sub_sub_file_2.writable()
	let elapsed_milliseconds= s:stopwatch.start()
	Assert elapsed_milliseconds < 1000
endfunction

function! s:Test_bottom_dir_get_files_with_extension_recursive_js()
	let stopwatch= Stopwatch()
	call stopwatch.start()
	let js_list= s:dir.get_files_with_extension_recursive('js')
	let elapsed= stopwatch.stop()
	AssertEquals(6, len(js_list))
	" make sure it didn't get slower than it already was:
	Assert elapsed < 40
	" make it faster:
	Assert elapsed < 35
endfunction
