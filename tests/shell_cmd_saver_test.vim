UTSuite shell_cmd_saver

function! s:Test_before_run_last_cmd_is_null()
	let shell= L_shell_cmd_saver()
	AssertEquals(L_null(), shell.last_cmd)
endfunction

function! s:Test_run_sets_last_cmd()
	let shell= L_shell_cmd_saver()
	call shell.run('i am a command')
	AssertEquals('i am a command', shell.last_cmd)
endfunction
