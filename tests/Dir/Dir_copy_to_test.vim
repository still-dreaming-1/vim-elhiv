UTSuite Dir_copy_to

function! s:Test_copy_to()
	let shell= Shell_cmd_saver()
	let dir= Dir('/parent/that_one_dir')
	let dir._shell= shell
	let copy= Dir('/parent/other_dir')
	call dir.copy_to(copy)
endfunction
