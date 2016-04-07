UTSuite ls

function! s:Test_new()
	let l:ls= l_ls#new()
	AssertEquals(0, l:ls.len())
	AssertEquals([], l:ls.ls)
endfunction

function! s:Test_new_from_empty_list()
	let l:ls= l_ls#new([])
	AssertEquals(0, l:ls.len())
	AssertEquals([], l:ls.ls)
endfunction

function! s:Test_add_1_value()
	let l:ls= l_ls#new()
	call l:ls.add(8)
	AssertEquals(1, l:ls.len())
	AssertEquals([8], l:ls.ls)
endfunction

function! s:Test_new_from_list_with_1_value()
	let l:ls= l_ls#new([8])
	AssertEquals(1, l:ls.len())
	AssertEquals([8], l:ls.ls)
endfunction

function! s:Test_add_2_values()
	let l:ls= l_ls#new()
	call l:ls.add(10)
	call l:ls.add('a')
	AssertEquals(2, l:ls.len())
	AssertEquals([10, 'a'], l:ls.ls)
endfunction

function! s:Test_create_from_list_with_2_values()
	let l:ls= l_ls#new([10, 'a'])
	AssertEquals(2, l:ls.len())
	AssertEquals([10, 'a'], l:ls.ls)
endfunction

function! s:Test_empty_not_contains()
	let l:ls= l_ls#new()
	Assert !l:ls.contains('e')
endfunction

function! s:Test_contains_single_value()
	let l:ls= l_ls#new()
	call l:ls.add('e')
	Assert l:ls.contains('e')
	Assert !l:ls.contains(9)
endfunction

function! s:Test_contains_two_values()
	let l:ls= l_ls#new()
	call l:ls.add(1)
	call l:ls.add(0)
	Assert l:ls.contains(1)
	Assert l:ls.contains(0)
	Assert l:ls.contains(1)
	Assert !l:ls.contains(2)
endfunction

function! s:Test_only_contains_str_0()
	let l:ls= l_ls#new()
	call l:ls.add('0')
	Assert l:ls.contains('0')
	Assert !l:ls.contains(0)
	Assert !l:ls.contains(1)
endfunction

function! s:Test_only_contains_str_1()
	let l:ls= l_ls#new()
	call l:ls.add('1')
	Assert l:ls.contains('1')
	Assert !l:ls.contains(1)
	Assert !l:ls.contains(0)
endfunction

function! s:Test_only_contains_number_0()
	let l:ls= l_ls#new()
	call l:ls.add(0)
	Assert l:ls.contains(0)
	Assert !l:ls.contains('0')
	Assert !l:ls.contains('1')
endfunction

function! s:Test_only_contains_number_1()
	let l:ls= l_ls#new()
	call l:ls.add(1)
	Assert l:ls.contains(1)
	Assert !l:ls.contains('1')
	Assert !l:ls.contains('0')
endfunction
