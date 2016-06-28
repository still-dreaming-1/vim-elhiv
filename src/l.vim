" A class for a collection of 'static' functions that are unrelated and do not use object state. Look in elhiv.vim to see the g:l variable get defined which should be used to call these
" functions. Of course a more standard approach to accomplishing this would be to use autoload functions, but then I would need to adhere to this project's rule of only using other
" autoload functions from inside the autoload functions. I am trying to keep the autoload functions as minimal as possible so that everything does not need to be moved there. I don't
" want everything to be moved there because then I would have to use the syntax supported there, which I am trying to avoid as part of adhering to the elh part of elhiv (extreme
" language hacking in VimL)
function! L_l()
	let l= {}
	
	" uses a global_log object to log stuff to the global log file as defined by the user
	function! l.log(line)
		call L_global_log().log(a:line)
	endfunction

	return l
endfunction

function! Get_cursor_char()
	return getline(".")[col(".")-1]
endfunction
