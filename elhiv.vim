" source this file in order to have access to the library. This file sources the other classes and functions in the library.

let s:current_script_path= expand('<sfile>')
let s:elhiv_dir_info= l_dir_info#new(s:current_script_path).parent()
let s:src_dir_info= s:elhiv_dir_info.get_contained_dir_info('src')
for s:file_to_source in s:src_dir_info.get_all_file_info()
	execute 'source '.s:file_to_source.path
endfor
let g:elhiv_dir_path= s:elhiv_dir_info.path
