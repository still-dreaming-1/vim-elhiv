UTSuite Dir

function! s:Test_path()
	AssertEquals('/i_am_the_path', Dir('/i_am_the_path').path)
endfunction

function! s:Test_can_be_root()
	let dir= Dir('/')
	AssertEquals('/', dir.path)
	Assert dir.exists()
endfunction

function! s:Test_parent()
	AssertEquals('/i_am_the_parent', Dir('/i_am_the_parent/made_up_non_existent_dir').parent().path)
endfunction

function! s:Test_root_has_no_parent()
	AssertEquals(Null(), Dir('/').parent())
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
	Assert !Dir('').exists()
endfunction

function! s:Test_home_dir_exists()
	Assert Dir('/home').exists()
endfunction

function! s:Test_contained_dir_has_correct_path()
	let dir= Dir('/some_dir')
	let contained_dir= dir.get_contained_dir('inside')
	AssertEquals('/some_dir/inside', contained_dir.path)
endfunction

function! s:Test_contained_file_has_correct_path()
	let dir= Dir('/some_dir')
	let contained_file= dir.get_contained_file('myfile.txt')
	AssertEquals('/some_dir/myfile.txt', contained_file.path)
endfunction

function! s:Test_not_subdir_of_non_existent_dir()
	let mom= Dir('mommy')
	let baby= mom.get_contained_dir('baby')
	Assert !baby.is_subdir_of(mom)
endfunction

function! s:Test_non_existent_dir_not_has_subdir()
	let mom= Dir('mommy')
	let baby= mom.get_contained_dir('baby')
	Assert !mom.has_subdir(baby)
endfunction

function! s:Test_child_not_subdir_of_parent_when_parent_contains_no_dirs()
	let parent= Dir(g:elhiv_dir_path).get_contained_dir('tests/Dir/data')
	Assert parent.exists()
	let child= parent.get_contained_dir('I do not exist')
	Assert !child.exists()
	Assert !child.is_subdir_of(parent)
endfunction

function! s:Test_parent_not_has_subdir_when_parent_contains_no_dirs()
	let parent= Dir(g:elhiv_dir_path).get_contained_dir('tests/Dir/data')
	Assert parent.exists()
	let child= parent.get_contained_dir('I do not exist')
	Assert !child.exists()
	Assert !parent.has_subdir(child)
endfunction

function! s:Test_child_not_subdir_of_parent_when_parent_only_contains_other_children()
	let parent= Dir(g:elhiv_dir_path).get_contained_dir('tests/Dir')
	Assert parent.exists()
	let non_existent_child= parent.get_contained_dir('I do not exist')
	Assert !non_existent_child.exists()
	let real_child= parent.get_contained_dir('data')
	Assert real_child.exists()
	Assert !non_existent_child.is_subdir_of(parent)
endfunction

function! s:Test_parent_not_has_subdir_when_only_has_other_children()
	let parent= Dir(g:elhiv_dir_path).get_contained_dir('tests/Dir')
	Assert parent.exists()
	let non_existent_child= parent.get_contained_dir('I do not exist')
	Assert !non_existent_child.exists()
	let real_child= parent.get_contained_dir('data')
	Assert real_child.exists()
	Assert !parent.has_subdir(non_existent_child)
endfunction
