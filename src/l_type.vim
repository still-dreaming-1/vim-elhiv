" comare these values to what is returned by the type() function
function! l_type#num()
	return 0
endfunction!

function! l_type#string()
	return 1
endfunction

function! l_type#fun()
	return 2
endfunction

function! l_type#list()
	return 3
endfunction

function! l_type#dictionary()
	return 4
endfunction

function! l_type#float()
	return 5
endfunction
