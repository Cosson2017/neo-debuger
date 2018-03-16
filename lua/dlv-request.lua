--------------------------------------------------
--    LICENSE: MIT
--     Author: Cosson2017
--    Version: 0.1
-- CreateTime: 2018-03-16 13:48:29
-- LastUpdate: 2018-03-16 13:48:29
--       Desc: 
--------------------------------------------------

local module = {}

module.dlv_id = 0
module.chan_id = 0

function module.dlv_start(path)
	module.dlv_id = vim.api.nvim_call_function("jobstart", {{"dlv", path, "-l", "localhost:60067"}})
	if module.dlv_id == 0 then
		vim.api.nvim_err_writeln("start dlv failed")
	else
		vim.api.nvim_out_write("start dlv success " .. module.dlv_id .. "\n")
	end
end

function module.dlv_stop()
	vim.api.nvim_call_function("jobstop", {module.dlv_id})
end

function module.dlv_connect(addr, port)
	module.chan_id = vim.api.nvim_call_function("dlv#server_connect", {addr, port})
	if module.chan_id ~= 0 then
		vim.api.nvim_out_write("connect dlv success\n")
	else
		vim.api.nvim_err_writeln("connect dlv failed")
	end
end

function module.dlv_send(data)
	vim.api.nvim_call_function("chansend", {module.chan_id, data})
end

function module.dlv_recieve(job_id, data, event)
	local str = ""
	for k, v in ipairs(data) do
		str = str .. v
	end
	print(str)
end

function module.connect_close()
	vim.api.nvim_call_function("chanclose", {module.chan_id})
end

return module
