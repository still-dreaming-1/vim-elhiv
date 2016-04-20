" source this file in order to have access to the library. This file sources the other classes and functions in the library. Some classes are defined here
" because they are used to find the correct path to source for the other library files.

" Null is useful when a method needs to either return the desired result, or Null when the result could not be calculated. This can be better than returning 0
" because sometimes 0 is hard to accurately compare to other values. Only return null if it will only be compared to other dictionaries as dictionaries can only
" be compared to each other (with == ).
function! Null()
	return { 'is_null' : 1 }
endfunction

function! Dir(path)
	let dir= {
		\ 'path' : a:path,
		\ 'exists' : isdirectory(a:path) }

	function! dir.parent()
		let last_slash_idx= strridx(self.path, '/', len(self.path) - 2)
		if last_slash_idx < 1 "0 or -1
			return Null()
		endif
		return Dir(self.path[0:last_slash_idx - 1])
	endfunction

	function! dir.get_contained_dir(name)
		return Dir(self.path.'/'.a:name)
	endfunction

	function! dir.get_contained_file(name)
		return File(self.path.'/'.a:name)
	endfunction
	
	function! dir.copy_to(dir)
		let cmd= 'cp "'.self.path.'" "'.a:dir.path.'"'
		" return system(cmd)
		return cmd
	endfunction

	return dir
endfunction

let s:current_script_path= expand('<sfile>')

function! Elhiv_dir()
	let dir= Dir(s:current_script_path).parent()

	function! dir.get_src_dir()
		return self.get_contained_dir('src')
	endfunction

	return dir
endfunction

let s:src_dir_path= Elhiv_dir().get_src_dir().path

execute 'source '.s:src_dir_path.'/Current_buf.vim'
execute 'source '.s:src_dir_path.'/Current_cursor.vim'
execute 'source '.s:src_dir_path.'/Dir.vim'
execute 'source '.s:src_dir_path.'/l.vim'
execute 'source '.s:src_dir_path.'/U_ls.vim'
execute 'source '.s:src_dir_path.'/Ls.vim'
execute 'source '.s:src_dir_path.'/S.vim'
execute 'source '.s:src_dir_path.'/types.vim'
execute 'source '.s:src_dir_path.'/File.vim'
execute 'source '.s:src_dir_path.'/Elhiv_file.vim'
execute 'source '.s:src_dir_path.'/Shell_cmd_saver.vim'
execute 'source '.s:src_dir_path.'/Shell.vim'
