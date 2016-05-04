UTSuite File_modifying

function! s:Test_create_copy_and_delete()
	let dir= Dir(g:elhiv_dir_path).get_contained_dir('tests/File/data')
	let file= dir.get_contained_file('file')
	let file_copy= dir.get_contained_file('file copy')
	Assert !file.readable()
	call file.create()
	Assert file.readable()
	Assert !file_copy.readable()
	call file.copy_to(file_copy.path)
	Assert file_copy.readable()
	call file.delete()
	Assert !file.readable()
	call file_copy.delete()
	Assert !file_copy.readable()
endfunction
