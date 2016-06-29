" A class for a collection of static functions that are unrelated. These belong here in the src directory instead of the autoload directory because this file should get sourced by
" elhiv.vim so that it can use other files sourced there. I am avoiding putting these inside the autoload functions because then they would need to honor this project's rule of only
" using other autoload functions from inside the autoload functions. I am trying to keep the autoload functions as minimal as possible so that everything does not need to be moved
" there. I don't want everything to be moved there because then I would have to use the syntax supported there for everything, which I am trying to avoid as part of adhering to the
" elh programming philosophy part of elhiv (extreme language hacking in VimL)

" uses a global_log object to log stuff to the global log file as defined by the user
function! l#log(line)
	call L_global_log().log(a:line)
endfunction

function! l#get_cursor_char()
	return getline(".")[col(".")-1]
endfunction
