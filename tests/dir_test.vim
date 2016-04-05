UTSuite dir

function! s:Test_path()
	let l:dir= l_dir#new('/i_am_the_path')
	AssertEquals('/i_am_the_path', l:dir.path)
endfunction

function! s:Test_parent()
	let l:parent= l_dir#new('/i_am_the_parent/made_up_non_existent_dir').parent()
	AssertEquals('/i_am_the_parent', l:parent.path)
endfunction

function! s:Test_parent_with_no_starting_slash()
	let l:parent= l_dir#new('i_am_the_parent/made_up_non_existent_dir').parent()
	AssertEquals('i_am_the_parent', l:parent.path)
endfunction

function! s:Test_short_parent()
	let l:parent= l_dir#new('~/made_up_non_existent_dir').parent()
	AssertEquals('~', l:parent.path)
endfunction

function! s:Test_parent_when_child_ends_with_slash()
	let l:parent= l_dir#new('your_mom/made_up_non_existent_dir/').parent()
	AssertEquals('your_mom', l:parent.path)
endfunction

function! s:Test_short_parent_when_child_ends_with_slash()
	let l:parent= l_dir#new('~/made_up_non_existent_dir/').parent()
	AssertEquals('~', l:parent.path)
endfunction

function! s:Test_no_parent_when_child_short()
	let l:parent= l_dir#new('~').parent()
	AssertEquals(l#null(), l:parent)
endfunction

function! s:Test_no_parent_when_child_is_dot()
	let l:parent= l_dir#new('.').parent()
	AssertEquals(l#null(), l:parent)
endfunction

function! s:Test_no_parent_when_child_is_dot_slash()
	let l:parent= l_dir#new('./').parent()
	AssertEquals(l#null(), l:parent)
endfunction

function! s:Test_parent_is_dot()
	let l:parent= l_dir#new('./some_dir').parent()
	AssertEquals('.', l:parent.path)
endfunction

function! s:Test_path_not_static()
	let l:a= l_dir#new('a')
	let l:b= l_dir#new('b')
	AssertEquals('a', l:a.path)
	AssertEquals('b', l:b.path)
endfunction

function! s:Test_parent_not_static()
	let l:a= l_dir#new('/i_am_grandma/i_am_the_parent/made_up_non_existent_dir')
	let l:b= l_dir#new('~/made_up_non_existent_dir')
	let l:a_parent= l:a.parent()
	let l:b_parent= l:b.parent()
	let l:a_grandma= l:a_parent.parent()
	let l:b_grandma= l:b_parent.parent()
	AssertEquals('/i_am_grandma/i_am_the_parent/made_up_non_existent_dir', l:a.path)
	AssertEquals('/i_am_grandma/i_am_the_parent', l:a_parent.path)
	AssertEquals('~', l:b_parent.path)
	AssertEquals('/i_am_grandma', l:a_grandma.path)
	" AssertEquals(l#null(), l:b_grandma)
endfunction

function! s:Test_empty_dir_not_exists()
	let l:dir= l_dir#new('')
	AssertEquals(0, l:dir.exists)
endfunction

function! s:Test_home_dir_exists()
	let l:dir= l_dir#new('/home')
	AssertEquals(1, l:dir.exists)
endfunction
