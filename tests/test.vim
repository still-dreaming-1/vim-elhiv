UTSuite elhiv

function! s:Test_parse_parent_dir()
	let l:parent= elhiv#parse_parent_dir('~/made_up_non_existent_dir')
	Assert l:parent == '~'
endfunction
function! s:Test_parse_parent_dir_when_ends_with_slash()
	let l:parent= elhiv#parse_parent_dir('~/made_up_non_existent_dir/')
	Assert l:parent == '~'
endfunction
