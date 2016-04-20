" source this file in order to have access to the library. This file sources the other classes and functions in the library. Some classes are defined here
" because they are used to find the correct path to source for the other library files.

function! Dir(path)
	let dir= {
		\ 'path' : a:path,
		\ 'exists' : isdirectory(a:path) }

	function! dir.parent()
		let last_slash_idx= strridx(self.path, '/', len(self.path) - 2)
		if last_slash_idx < 1 "0 or -1
			return l_null#new()
		endif
		return Dir(self.path[0:last_slash_idx - 1])
	endfunction

	function! dir.get_contained_dir(name)
		return Dir(self.path.'/'.a:name)
	endfunction

	function! dir.get_contained_file(name)
		return File(self.path.'/'.a:name)
	endfunction
	
	" function! dir.copy_to(dir)
	" 	return self.shell.run('cp "'.self.path.'" "'.a:dir.path.'"')
	" endfunction

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

execute 'source '.s:src_dir_path.'/Null.vim'
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
