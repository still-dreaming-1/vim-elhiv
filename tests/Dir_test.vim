UTSuite dir

function! s:Test_path()
	AssertEquals('/i_am_the_path', Dir('/i_am_the_path').path)
endfunction

function! s:Test_parent()
	AssertEquals('/i_am_the_parent', Dir('/i_am_the_parent/made_up_non_existent_dir').parent().path)
endfunction

function! s:Test_parent_with_no_starting_slash()
	AssertEquals('i_am_the_parent', Dir('i_am_the_parent/made_up_non_existent_dir').parent().path)
endfunction

function! s:Test_short_parent()
	AssertEquals('~', Dir('~/made_up_non_existent_dir').parent().path)
endfunction

function! s:Test_parent_when_child_ends_with_slash()
	AssertEquals('your_mom', Dir('your_mom/made_up_non_existent_dir/').parent().path)
endfunction

function! s:Test_short_parent_when_child_ends_with_slash()
	AssertEquals('~', Dir('~/made_up_non_existent_dir/').parent().path)
endfunction

function! s:Test_no_parent_when_child_short()
	AssertEquals(Null(), Dir('~').parent())
endfunction

function! s:Test_no_parent_when_child_is_dot()
	AssertEquals(Null(), Dir('.').parent())
endfunction

function! s:Test_no_parent_when_child_is_dot_slash()
	AssertEquals(Null(), Dir('./').parent())
endfunction

function! s:Test_parent_is_dot()
	AssertEquals('.', Dir('./some_dir').parent().path)
endfunction

function! s:Test_empty_dir_not_exists()
	AssertEquals(0, Dir('').exists)
endfunction

function! s:Test_home_dir_exists()
	AssertEquals(1, Dir('/home').exists)
endfunction