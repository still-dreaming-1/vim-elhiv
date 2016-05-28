function! Shell()
	let me= {}
	let me._shell= l_shell#new()
	function me.run(command)
		let out= self._shell.run(a:command)
		if exists('g:l_shell_log') " should be a File object
			call g:l_shell_log.append_line('shell command: '.a:command)
			call g:l_shell_log.append_line('shell output: '.out)
		endif
		if exists('g:l_log') " should be a File object
			call g:l_log.append_line('shell command: '.a:command)
			call g:l_log.append_line('shell output: '.out)
		endif
		return out
	endfunction
	return me
endfunction
