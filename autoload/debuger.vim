
let s:jobid = 0

func! s:start_debuger(cmd)
	let s:jobid = jobstart(a:cmd, s:call_back)
endfunc

func! s:on_stdout(job_id, data, event)
	echo 'stdout: ' . string(a:data) . 'jobid' . a:job_id
endfunc

func! s:on_stderr(job_id, data, event)
	echo 'stderr: ' . string(a:data) . 'jobid' . a:job_id
endfunc

func! s:on_exit(job_id, data, event)
	echo 'exit: ' . string(a:data) . 'jobid' . a:job_id
endfunc

let s:call_back = {
	\ 'on_stdout': function('s:on_stdout'),
	\ 'on_stderr': function('s:on_stderr'),
	\ 'on_exit': function('s:on_exit'),
	\}

func! s:send_cmd()
endfunc

func! s:stop_debuger()
endfunc

func! debuger#start_debuger(...)
	call s:start_debuger(a:000)
endfunc
