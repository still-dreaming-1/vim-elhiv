UTSuite elhiv

function! s:Test_parse_parent_dir()
	let l:parent= elhiv#parse_parent_dir('~/made_up_non_existent_dir')
	AssertEquals('~', l:parent)
	AssertEquals(1, type(l:parent))
endfunction

function! s:Test_parse_parent_dir_when_ends_with_slash()
	let l:parent= elhiv#parse_parent_dir('~/made_up_non_existent_dir/')
	AssertEquals('~', l:parent)
	AssertEquals(1, type(l:parent)) " string type
endfunction

function! s:Test_parse_when_no_parent()
	let l:parent= elhiv#parse_parent_dir('~')
	AssertEquals(0, l:parent)
	AssertEquals(0, type(l:parent)) " number type
endfunction
