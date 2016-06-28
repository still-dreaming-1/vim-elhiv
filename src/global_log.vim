" global_log class
function! L_global_log()
	let global_log= {}

	function! global_log.log_is_enabled()
		return exists('g:l_log') " should be a file object
	endfunction

	function! global_log.log(line)
		if self.log_is_enabled()
			call g:l_log.append_line(a:line)
		endif
	endfunction

	return global_log
endfunction

" Log function that uses a global log object.
function! Log(line)
	call L_global_log().log(a:line)
endfunction
