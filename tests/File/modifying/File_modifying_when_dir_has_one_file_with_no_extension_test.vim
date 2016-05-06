UTSuite File modifying when directory has one file with no file extension

function! s:Setup()
	let s:dir= Dir(g:elhiv_dir_path).get_contained_dir('tests/File/data/generated')
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
