UTSuite L_dir

function! s:Test_path()
	AssertEquals('/i_am_the_path', L_dir('/i_am_the_path').path)
endfunction

function! s:Test_can_be_root()
	let dir= L_dir('/')
	AssertEquals('/', dir.path)
	Assert dir.exists()
endfunction

function! s:Test_parent()
	AssertEquals('/i_am_the_parent', L_dir('/i_am_the_parent/made_up_non_existent_dir').parent().path)
endfunction

function! s:Test_root_has_no_parent()
	AssertEquals(L_null(), L_dir('/').parent())
endfunction

function! s:Test_parent_with_no_starting_slash()
	AssertEquals('i_am_the_parent', L_dir('i_am_the_parent/made_up_non_existent_dir').parent().path)
endfunction

function! s:Test_short_parent()
	AssertEquals('~', L_dir('~/made_up_non_existent_dir').parent().path)
endfunction

function! s:Test_parent_when_child_ends_with_slash()
	AssertEquals('your_mom', L_dir('your_mom/made_up_non_existent_dir/').parent().path)
endfunction

function! s:Test_short_parent_when_child_ends_with_slash()
	AssertEquals('~', L_dir('~/made_up_non_existent_dir/').parent().path)
endfunction

function! s:Test_no_parent_when_child_short()
	AssertEquals(L_null(), L_dir('~').parent())
endfunction

function! s:Test_no_parent_when_child_is_dot()
	AssertEquals(L_null(), L_dir('.').parent())
endfunction

function! s:Test_no_parent_when_child_is_dot_slash()
	AssertEquals(L_null(), L_dir('./').parent())
endfunction

function! s:Test_parent_is_dot()
	AssertEquals('.', L_dir('./some_dir').parent().path)
endfunction

function! s:Test_empty_dir_not_exists()
	Assert !L_dir('').exists()
endfunction

function! s:Test_home_dir_exists()
	Assert L_dir('/home').exists()
endfunction

function! s:Test_contained_dir_has_correct_path()
	let dir= L_dir('/some_dir')
	let contained_dir= dir.get_contained_dir('inside')
	AssertEquals('/some_dir/inside', contained_dir.path)
endfunction

function! s:Test_contained_file_has_correct_path()
	let dir= L_dir('/some_dir')
	let contained_file= dir.get_contained_file('myfile.txt')
	AssertEquals('/some_dir/myfile.txt', contained_file.path)
endfunction

function! s:Test_not_subdir_of_non_existent_dir()
	let mom= L_dir('mommy')
	let baby= mom.get_contained_dir('baby')
	Assert !baby.is_subdir_of(mom)
endfunction

function! s:Test_non_existent_dir_not_has_subdir()
	let mom= L_dir('mommy')
	let baby= mom.get_contained_dir('baby')
	Assert !mom.has_subdir(baby)
endfunction

function! s:Test_child_not_subdir_of_parent_when_parent_contains_no_dirs()
	let parent= L_dir(g:elhiv_dir_path).get_contained_dir('static test data')
	Assert parent.exists()
	let child= parent.get_contained_dir('I do not exist')
	Assert !child.exists()
	Assert !child.is_subdir_of(parent)
endfunction

function! s:Test_parent_not_has_subdir_when_parent_contains_no_dirs()
	let parent= L_dir(g:elhiv_dir_path).get_contained_dir('static test data')
	Assert parent.exists()
	let child= parent.get_contained_dir('I do not exist')
	Assert !child.exists()
	Assert !parent.has_subdir(child)
endfunction

function! s:Test_child_not_subdir_of_parent_when_parent_only_contains_other_children()
	let parent= L_dir(g:elhiv_dir_path).get_contained_dir('static test data')
	Assert parent.exists()
	let non_existent_child= parent.get_contained_dir('I do not exist')
	Assert !non_existent_child.exists()
	let real_child= parent.get_contained_dir('empty dir')
	Assert real_child.exists()
	Assert !non_existent_child.is_subdir_of(parent)
endfunction

function! s:Test_parent_not_has_subdir_when_only_has_other_children()
	let parent= L_dir(g:elhiv_dir_path).get_contained_dir('static test data')
	Assert parent.exists()
	let non_existent_child= parent.get_contained_dir('I do not exist')
	Assert !non_existent_child.exists()
	let real_child= parent.get_contained_dir('empty dir')
	Assert real_child.exists()
	Assert !parent.has_subdir(non_existent_child)
endfunction

function! s:Test_is_subdir_of()
	let parent= L_dir(g:elhiv_dir_path).get_contained_dir('static test data')
	Assert parent.exists()
	let child= parent.get_contained_dir('empty dir')
	Assert child.exists()
	Assert child.is_subdir_of(parent)
endfunction

function! s:Test_has_subdir()
	let parent= L_dir(g:elhiv_dir_path).get_contained_dir('tests/dir')
	Assert parent.exists()
	let child= parent.get_contained_dir('data')
	Assert child.exists()
	Assert parent.has_subdir(child)
endfunction
