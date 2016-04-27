UTSuite File_modifying

function! s:Test_create_and_delete()
	let dir= Dir(g:elhiv_dir_path).get_contained_dir('tests/File/data')
	let file= dir.get_contained_file('file')
	Assert !file.readable()
	call file.create()
	Assert file.readable()
endfunction
