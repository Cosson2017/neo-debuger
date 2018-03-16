let g:dlv_cmd = {
			\ 'start': 'dlv',
			\ 'break': 'break',
			\ 'pb': 'breakpoints',
			\ 'cb': 'clear',
			\ 'cab': 'clearall',
			\ 'cn': 'continue',
			\ 'print': 'p',
			\ 'exit': 'exit',
			\ 'lvars': 'locals'
			\ }

" 连接dlv server
func dlv#server_connect(addr, port)
	let l:chan_id = sockconnect("tcp", a:addr . ":" . a:port, { 
				\ "on_data": function("dlv#server_data"),
				\ })
	return l:chan_id
endfunc

" 向dlv server发送数据
func dlv#server_send(chan_id, data)
	call chansend(a:chan_id, a:data)
endfunc

" 接收dlv server数据
func dlv#server_data(job_id, data, event)
	call luaeval("require('dlv-request').dlv_recieve(_A.jobid, _A.data, _A.event)", {
				\ "jobid": a:job_id,
				\ "data": a:data,
				\ "event": a:event,
				\ })
endfunc

" 关闭连接
func dlv#connect_close(job_id)
	call chanclose(a:job_id)
endfunc
