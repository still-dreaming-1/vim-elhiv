UTSuite elhiv

function! s:Test_parse_parent_dir()
	let l:parent= elhiv#parse_parent_dir('/i_am_the_parent/made_up_non_existent_dir')
	AssertEquals('/i_am_the_parent', l:parent)
endfunction

function! s:Test_parse_parent_dir_with_no_starting_slash()
	let l:parent= elhiv#parse_parent_dir('i_am_the_parent/made_up_non_existent_dir')
	AssertEquals('i_am_the_parent', l:parent)
endfunction

function! s:Test_parse_short_parent_dir()
	let l:parent= elhiv#parse_parent_dir('~/made_up_non_existent_dir')
	AssertEquals('~', l:parent)
endfunction

function! s:Test_parse_parent_dir_when_ends_with_slash()
	let l:parent= elhiv#parse_parent_dir('your_mom/made_up_non_existent_dir/')
	AssertEquals('your_mom', l:parent)
endfunction

function! s:Test_parse_short_parent_dir_when_ends_with_slash()
	let l:parent= elhiv#parse_parent_dir('~/made_up_non_existent_dir/')
	AssertEquals('~', l:parent)
endfunction

function! s:Test_parse_short_when_no_parent()
	let l:parent= elhiv#parse_parent_dir('~')
	AssertEquals('', l:parent)
endfunction

function! s:Test_parse_no_parent_when_dir_is_dot()
	let l:parent= elhiv#parse_parent_dir('.')
	AssertEquals('', l:parent)
endfunction

function! s:Test_parse_no_parent_when_dir_is_dot_slash()
	let l:parent= elhiv#parse_parent_dir('./')
	AssertEquals('', l:parent)
endfunction

function! s:Test_parse_when_parent_is_dot()
	let l:parent= elhiv#parse_parent_dir('./some_dir')
	AssertEquals('.', l:parent)
endfunction
