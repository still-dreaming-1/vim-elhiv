" source this file in order to have access to the library. This file sources
" the other classes and functions in the library.

" At this point, this code can only use what is has access to, which is the
" VimL language as provided by the editor, and the autoload classes, which
" serve as a bootstrap. If the autoload classes are a bootstrap, then the
" files in the src directory must be the boot or the core 'language'. The main
" goal at this point is to source the boot so it can be used:
let s:current_script_path= expand('<sfile>')
let s:elhiv_dir_info= l_dir_info#new(s:current_script_path).parent()
let s:src_dir_info= s:elhiv_dir_info.get_contained_dir_info('src')
for s:file_to_source in s:src_dir_info.get_all_file_info()
	execute 'source '.s:file_to_source.path
endfor
" The boot / core 'language' has been sourced, but many things rely on this
" global variable, so let's set it up now:
let g:elhiv_dir_path= s:elhiv_dir_info.path
" The boot and global varaibles are now setup. Now we need to source other
" 'languages' built on top of the base 'language' / boot. Since the boot has
" been sourced, we are now free to use it to help us source the other
" 'languages'.
let s:src_dir= L_dir(s:src_dir_info.path)
let s:tags_dir= s:src_dir.get_contained_dir('tags')
for s:file_to_source in s:tags_dir.get_all_files()
	execute 'source '.s:file_to_source.path
endfor
let g:elhiv_dir= L_dir(g:elhiv_dir_path)
