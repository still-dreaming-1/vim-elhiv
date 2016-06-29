UTSuite S

function! s:Test_str()
	let s= L_s('hello')
	AssertEquals('hello', s.str)
endfunction

function! s:Test_len_of_empty_string_is_0()
	let s= L_s('')
	AssertEquals(0, s.len)
endfunction

function! s:Test_len_of_string_with_1_char()
	let s= L_s('d')
	AssertEquals(1, s.len)
endfunction

function! s:Test_len_of_longer_string()
	let s= L_s('I am a 27 character string!')
	AssertEquals(27, s.len)
endfunction

function! s:Test_contains_when_searching_for_the_only_char()
	let s= L_s('1')
	Assert s.contains('1')
endfunction

function! s:Test_contains_when_searching_for_the_entire_string()
	let s= L_s('normal sized string')
	Assert s.contains('normal sized string')
endfunction

function! s:Test_contains_when_searching_for_middle_of_string()
	let s= L_s('normal sized string')
	Assert s.contains('sized')
endfunction

function! s:Test_not_contains()
	let s= L_s('2')
	Assert !s.contains('1')
endfunction

function! s:Test_not_contains_when_empty()
	let s= L_s('')
	Assert !s.contains('1')
endfunction

function! s:Test_ridx()
	let s= L_s(';ok;there')
	AssertEquals(3, s.ridx(';'))
endfunction

function! s:Test_ridx_with_multi_char_str()
	let s= L_s(';ok;there')
	AssertEquals(1, s.ridx('ok'))
endfunction

function! s:Test_ridx_with_nothing_before_match()
	let s= L_s('/some dir/another dir/filename')
	AssertEquals(0, s.ridx('/some'))
endfunction

function! s:Test_not_starts_with_ending()
	Assert !L_s('one').starts_with('e')
endfunction

function! s:Test_not_starts_with_longer_string()
	Assert !L_s('same').starts_with('same I am longer than you')
endfunction

function! s:Test_starts_with_self()
	Assert L_s('one').starts_with('one')
endfunction

function! s:Test_starts_with_first_2_chars()
	Assert L_s('one').starts_with('on')
endfunction

function! s:Test_starts_with_first_char()
	Assert L_s('one').starts_with('o')
endfunction

function! s:Test_not_starts_with_first_char_when_different_capitalization()
	Assert !L_s('one').starts_with('O')
endfunction

function! s:Test_not_ends_with_start()
	Assert !L_s('one').ends_with('on')
endfunction

function! s:Test_not_ends_with_longer_string()
	Assert !L_s('same').starts_with('I am longer than you same')
endfunction

function! s:Test_ends_with_self()
	Assert L_s('one').ends_with('one')
endfunction

function! s:Test_ends_with_last_2_chars()
	Assert L_s('one').ends_with('ne')
endfunction

function! s:Test_ends_with_last_char()
	Assert L_s('one').ends_with('e')
endfunction

function! s:Test_not_ends_with_last_char_when_different_capitalization()
	Assert !L_s('one').ends_with('E')
endfunction

function! s:Test_1_ends_with_1()
	Assert L_s('1').ends_with('1')
endfunction

function! s:Test_0_ends_with_0()
	Assert L_s('0').ends_with('0')
endfunction

function! s:Test_0_not_ends_with_1()
	Assert !L_s('0').ends_with('1')
endfunction

function! s:Test_1_not_ends_with_0()
	Assert !L_s('1').ends_with('0')
endfunction

function! s:Test_remove_end_of_single_char_string()
	AssertEquals('', L_s('a').remove_end().str)
endfunction

function! s:Test_remove_end_of_2_char_string()
	AssertEquals('a', L_s('ab').remove_end().str)
endfunction

function! s:Test_remove_end_of_3_char_string()
	AssertEquals('xy', L_s('xyz').remove_end().str)
endfunction

function! s:Test_escape_space()
	AssertEquals('\ ', L_s(' ').escape(' ').str)
endfunction

function! s:Test_escape_space_between_two_words()
	AssertEquals('some\ name', L_s('some name').escape(' ').str)
endfunction

function! s:Test_remove_start_long_string()
	AssertEquals(' am kind of a long string', L_s('I am kind of a long string').remove_start().str)
endfunction

function! s:Test_remove_start_of_2_char_string()
	AssertEquals('b', L_s('ab').remove_start().str)
endfunction

function! s:Test_remove_start_of_1_char_string()
	AssertEquals('', L_s('v').remove_start().str)
endfunction

function! s:Test_remove_start_of_empty_str()
	AssertEquals('', L_s('').remove_start().str)
endfunction

function! s:Test_trim_space_from_beginning()
	AssertEquals('yes', L_s(' yes').trim().str)
endfunction

function! s:Test_trim_line_feed_from_beginning()
	AssertEquals('no', L_s("\nno").trim().str)
endfunction

function! s:Test_trim_line_feed_from_end()
	AssertEquals('well', L_s("well\n").trim().str)
endfunction

function! s:Test_trim_2_spaces_from_beginning()
	AssertEquals('watermellon', L_s('  watermellon').trim().str)
endfunction

function! s:Test_trim_space_from_end()
	AssertEquals('beef', L_s('beef ').trim().str)
endfunction

function! s:Test_trim_2_spaces_from_end()
	AssertEquals('clouds', L_s('clouds  ').trim().str)
endfunction

function! s:Test_trim_space_from_beginning_and_end()
	AssertEquals('tree', L_s(' tree ').trim().str)
endfunction

function! s:Test_trim_2_spaces_from_beginning_and_end()
	AssertEquals('tree', L_s('  tree  ').trim().str)
endfunction

function! s:Test_trim_space_to_empty_string()
	AssertEquals('', L_s(' ').trim().str)
endfunction

function! s:Test_trim_2_spaces_to_empty_string()
	AssertEquals('', L_s('  ').trim().str)
endfunction

function! s:Test_trim_when_nothing_to_change()
	AssertEquals("don't gotta trim me", L_s("don't gotta trim me").trim().str)
endfunction

function! s:Test_trim_when_nothing_to_change_but_there_are_spaces_close_to_the_start_and_end()
	AssertEquals('I should not change .', L_s('I should not change .').trim().str)
endfunction

function! s:Test_trim_empty_string()
	AssertEquals('', L_s('').trim().str)
endfunction

function! s:Test_after_last_when_multiple_single_char_search()
	AssertEquals('filename', L_s('/some dir/another dir/filename').after_last('/').str)
endfunction

function! s:Test_after_last_when_one_single_char_search()
	AssertEquals('txt', L_s('/some dir/another dir/filename.txt').after_last('.').str)
endfunction

function! s:Test_after_last_when_nothing_after_last()
	AssertEquals('', L_s('/some dir/another dir/filename').after_last('filename').str)
endfunction

function! s:Test_after_last_when_search_not_found()
	AssertEquals('', L_s('/some dir/another dir/filename.txt').after_last('4').str)
endfunction

function! s:Test_after_last_when_str_is_empty()
	AssertEquals('', L_s('').after_last('a').str)
endfunction

function! s:Test_before_last_when_multiple_single_char_search()
	AssertEquals('/some dir/another dir', L_s('/some dir/another dir/filename').before_last('/').str)
endfunction

function! s:Test_before_last_when_one_single_char_search()
	AssertEquals('/some dir/another dir/filename', L_s('/some dir/another dir/filename.txt').before_last('.').str)
endfunction

function! s:Test_before_last_when_nothing_before_last()
	AssertEquals('', L_s('/some dir/another dir/filename').before_last('/some').str)
endfunction

function! s:Test_before_last_when_search_not_found()
	AssertEquals('/some dir/another dir/filename.txt', L_s('/some dir/another dir/filename.txt').before_last('4').str)
endfunction

function! s:Test_before_last_when_str_is_empty()
	AssertEquals('', L_s('').before_last('a').str)
endfunction
