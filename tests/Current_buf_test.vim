UTSuite Current_buf

let s:current_path= expand('<sfile>')
function! s:Test_file()
	let this_file= File(s:current_path)
	call this_file.edit()
	let buffer_file= Current_buf().file()
	AssertEquals(this_file.path, buffer_file.path)
endfunction
