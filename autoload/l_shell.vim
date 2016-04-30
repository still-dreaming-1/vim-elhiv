function! l_shell#new()
	let shell= {}
	
	function! shell.run(cmd)
		return system(a:cmd)
	endfunction

	return shell
endfunction
