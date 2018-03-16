local module = {}

local jsonRequestObject = {
	jsonrpc	="2.0",
	method	="remote_method",
	params	= {},
	id = 1,
}

local findLocation = {
	jsonrpc	=	"2.0",
	method	=	"RPCServer.FindLocation",
	params	=	{
		{
			Scope	=	{ GoroutineID = -1, Frame = 0 },
			Loc		=	"main.main",
		}
	},
	id		=	2,
}

local createBreakpoint = {
	josnrpc = "2.0",
	method = "PCServer.CreateBreakpoint",
	id = 3,
	params = {
		{
			Breakpoint = {addr = 4199019}
		}
	},
}

--print(vim.api.nvim_call_function('json_encode', {findLocation}))
--print(vim.api.nvim_call_function('json_encode', {createBreakpoint}))

return module
