function! File(path)
	let file= { 'path' : a:path }
	let file.readable= filereadable(file.path)
	return file
endfunction
