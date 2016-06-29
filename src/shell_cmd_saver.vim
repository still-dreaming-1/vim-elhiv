function! L_shell_cmd_saver()
	let saver= {}
	let saver.last_cmd= L_null()
	
	function! saver.run(cmd)
		let self.last_cmd= a:cmd
	endfunction

	return saver
endfunction
