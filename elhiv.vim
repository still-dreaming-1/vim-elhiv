" source this file in order to have access to the library. This file sources the other classes and functions in the library. Some classes are defined here
" because they are used to find the correct path to source for the other library files.

" Null is useful when a method needs to either return the desired result, or Null when the result could not be calculated. This can be better than returning 0
" because sometimes 0 is hard to accurately compare to other values. Only return null if it will only be compared to other dictionaries as dictionaries can only
" be compared to each other (with == ).
function! Null()
	return { 'is_null' : 1 }
endfunction

function! Dir(path)
	let l:dir= {
		\ 'path' : a:path,
		\ 'exists' : isdirectory(a:path) }

	function! l:dir.parent()
		let l:last_slash_idx= strridx(self.path, '/', len(self.path) - 2)
		if l:last_slash_idx < 1 "0 or -1
			return Null()
		endif
		return Dir(self.path[0:l:last_slash_idx - 1])
	endfunction

	return l:dir
endfunction

let s:current_script_path= expand('<sfile>')
let s:src_dir= Dir(s:current_script_path).parent().path.'/src/'
execute 'source '.s:src_dir.'Current_buf.vim'
execute 'source '.s:src_dir.'Cursor.vim'
execute 'source '.s:src_dir.'Dir.vim'
execute 'source '.s:src_dir.'l.vim'
execute 'source '.s:src_dir.'U_ls.vim'
execute 'source '.s:src_dir.'Ls.vim'
execute 'source '.s:src_dir.'S.vim'
execute 'source '.s:src_dir.'types.vim'
