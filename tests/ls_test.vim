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
