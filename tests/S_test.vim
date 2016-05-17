UTSuite S

function! s:Test_str()
	let s= S('hello')
	AssertEquals('hello', s.str)
endfunction

function! s:Test_len_of_empty_string_is_0()
	let s= S('')
	AssertEquals(0, s.len)
endfunction

function! s:Test_len_of_string_with_1_char()
	let s= S('d')
	AssertEquals(1, s.len)
endfunction

function! s:Test_len_of_longer_string()
	let s= S('I am a 27 character string!')
	AssertEquals(27, s.len)
endfunction

function! s:Test_ridx()
	let s= S(';ok;there')
	AssertEquals(3, s.ridx(';'))
endfunction

function! s:Test_ridx_with_multi_char_str()
	let s= S(';ok;there')
	AssertEquals(1, s.ridx('ok'))
endfunction

function! s:Test_ridx_with_nothing_before_match()
	let s= S('/some dir/another dir/filename')
	AssertEquals(0, s.ridx('/some'))
endfunction

function! s:Test_not_starts_with_ending()
	Assert !S('one').starts_with('e')
endfunction

function! s:Test_not_starts_with_longer_string()
	Assert !S('same').starts_with('same I am longer than you')
endfunction

function! s:Test_starts_with_self()
	Assert S('one').starts_with('one')
endfunction

function! s:Test_starts_with_first_2_chars()
	Assert S('one').starts_with('on')
endfunction

function! s:Test_starts_with_first_char()
	Assert S('one').starts_with('o')
endfunction

function! s:Test_not_starts_with_first_char_when_different_capitalization()
	Assert !S('one').starts_with('O')
endfunction

function! s:Test_not_ends_with_start()
	Assert !S('one').ends_with('on')
endfunction

function! s:Test_not_ends_with_longer_string()
	Assert !S('same').starts_with('I am longer than you same')
endfunction

function! s:Test_ends_with_self()
	Assert S('one').ends_with('one')
endfunction

function! s:Test_ends_with_last_2_chars()
	Assert S('one').ends_with('ne')
endfunction

function! s:Test_ends_with_last_char()
	Assert S('one').ends_with('e')
endfunction

function! s:Test_not_ends_with_last_char_when_different_capitalization()
	Assert !S('one').ends_with('E')
endfunction

function! s:Test_remove_end_of_single_char_string()
	AssertEquals('', S('a').remove_end().str)
endfunction

function! s:Test_remove_end_of_2_char_string()
	AssertEquals('a', S('ab').remove_end().str)
endfunction

function! s:Test_remove_end_of_3_char_string()
	AssertEquals('xy', S('xyz').remove_end().str)
endfunction

function! s:Test_escape_space()
	AssertEquals('\ ', S(' ').escape(' ').str)
endfunction

function! s:Test_escape_space_between_two_words()
	AssertEquals('some\ name', S('some name').escape(' ').str)
endfunction

function! s:Test_remove_start_long_string()
	AssertEquals(' am kind of a long string', S('I am kind of a long string').remove_start().str)
endfunction

function! s:Test_remove_start_of_2_char_string()
	AssertEquals('b', S('ab').remove_start().str)
endfunction

function! s:Test_remove_start_of_1_char_string()
	AssertEquals('', S('v').remove_start().str)
endfunction

function! s:Test_remove_start_of_empty_str()
	AssertEquals('', S('').remove_start().str)
endfunction

function! s:Test_trim_space_from_beginning()
	AssertEquals('yes', S(' yes').trim().str)
endfunction

function! s:Test_trim_line_feed_from_beginning()
	AssertEquals('no', S("\nno").trim().str)
endfunction

function! s:Test_trim_line_feed_from_end()
	AssertEquals('well', S("well\n").trim().str)
endfunction

function! s:Test_trim_2_spaces_from_beginning()
	AssertEquals('watermellon', S('  watermellon').trim().str)
endfunction

function! s:Test_trim_space_from_end()
	AssertEquals('beef', S('beef ').trim().str)
endfunction

function! s:Test_trim_2_spaces_from_end()
	AssertEquals('clouds', S('clouds  ').trim().str)
endfunction

function! s:Test_trim_space_from_beginning_and_end()
	AssertEquals('tree', S(' tree ').trim().str)
endfunction

function! s:Test_trim_2_spaces_from_beginning_and_end()
	AssertEquals('tree', S('  tree  ').trim().str)
endfunction

function! s:Test_trim_space_to_empty_string()
	AssertEquals('', S(' ').trim().str)
endfunction

function! s:Test_trim_2_spaces_to_empty_string()
	AssertEquals('', S('  ').trim().str)
endfunction

function! s:Test_trim_when_nothing_to_change()
	AssertEquals("don't gotta trim me", S("don't gotta trim me").trim().str)
endfunction

function! s:Test_trim_when_nothing_to_change_but_there_are_spaces_close_to_the_start_and_end()
	AssertEquals('I should not change .', S('I should not change .').trim().str)
endfunction

function! s:Test_trim_empty_string()
	AssertEquals('', S('').trim().str)
endfunction

function! s:Test_after_last_when_multiple_single_char_search()
	AssertEquals('filename', S('/some dir/another dir/filename').after_last('/').str)
endfunction

function! s:Test_after_last_when_one_single_char_search()
	AssertEquals('txt', S('/some dir/another dir/filename.txt').after_last('.').str)
endfunction

function! s:Test_after_last_when_nothing_after_last()
	AssertEquals('', S('/some dir/another dir/filename').after_last('filename').str)
endfunction

function! s:Test_after_last_when_search_not_found()
	AssertEquals('', S('/some dir/another dir/filename.txt').after_last('4').str)
endfunction

function! s:Test_after_last_when_str_is_empty()
	AssertEquals('', S('').after_last('a').str)
endfunction

function! s:Test_before_last_when_multiple_single_char_search()
	AssertEquals('/some dir/another dir', S('/some dir/another dir/filename').before_last('/').str)
endfunction

function! s:Test_before_last_when_one_single_char_search()
	AssertEquals('/some dir/another dir/filename', S('/some dir/another dir/filename.txt').before_last('.').str)
endfunction

function! s:Test_before_last_when_nothing_before_last()
	AssertEquals('', S('/some dir/another dir/filename').before_last('/some').str)
endfunction

function! s:Test_before_last_when_search_not_found()
	AssertEquals('/some dir/another dir/filename.txt', S('/some dir/another dir/filename.txt').before_last('4').str)
endfunction

function! s:Test_before_last_when_str_is_empty()
	AssertEquals('', S('').before_last('a').str)
endfunction
