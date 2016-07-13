UTSuite L_current_buffer

let s:current_path= expand('<sfile>')
function! s:Test_file()
	let this_file= L_file(s:current_path)
	call this_file.edit()
	let buffer_file= L_current_buffer().file()
	AssertEquals(this_file.path, buffer_file.path)
endfunction
