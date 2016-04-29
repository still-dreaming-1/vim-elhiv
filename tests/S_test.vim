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
