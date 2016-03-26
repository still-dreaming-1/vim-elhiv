UTSuite elhiv

function! s:Test_parse_parent_dir()
	let l:parent= elhiv#parse_parent_dir('~/.config')
	Assert l:parent == '~'
endfunction
