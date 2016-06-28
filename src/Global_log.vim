" Global_log class
function! Global_log()
	let global_log= {}

	function! global_log.log_is_enabled()
		return exists('g:l_log') " should be a L_file object
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
	call Global_log().log(a:line)
endfunction
