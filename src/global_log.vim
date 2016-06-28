" global_log class
function! L_global_log()
	let global_log= {}

	function! global_log.log_is_enabled()
		return exists('g:l_log') " should be a file object created by the user to point to whatever file they want to use for their global log
	endfunction

	function! global_log.log(line)
		if self.log_is_enabled()
			call g:l_log.append_line(a:line)
		endif
	endfunction

	return global_log
endfunction
