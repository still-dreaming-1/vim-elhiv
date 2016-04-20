function! File(path)
	let l:file= { 'path' : a:path }
	let l:file.readable= filereadable(l:file.path)
	return l:file
endfunction
