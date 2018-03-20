--------------------------------------------------
--    LICENSE: MIT
--     Author: Cosson2017
--    Version: 0.1
-- CreateTime: 2018-03-16 13:48:29
-- LastUpdate: 2018-03-19 17:09:21
--       Desc: 
--------------------------------------------------

local module = {}

-- 导入模块
local json = require("dlv.json")
local inspect = require("inspect")

-- 模块变量
module.dlv_id = 0
module.chan_id = 0

-- 本地变量
local req_cb = {} -- map[id]cb
local req_id = 0

function module.start(path)
	module.dlv_id = vim.api.nvim_call_function("jobstart", {{"dlv", path, "-l", "localhost:60067"}})
	if module.dlv_id == 0 then
		vim.api.nvim_err_writeln("start dlv failed")
	else
		vim.api.nvim_out_write("start dlv success " .. module.dlv_id .. "\n")
	end
end

function module.stop()
	vim.api.nvim_call_function("jobstop", {module.dlv_id})
end

function module.connect(addr, port)
	module.chan_id = vim.api.nvim_call_function("dlv#server_connect", {addr, port})
	if module.chan_id ~= 0 then
		vim.api.nvim_out_write("connect dlv success\n")
	else
		vim.api.nvim_err_writeln("connect dlv failed")
	end
end

-- @data: rpc data
-- @cb: callback
function module.send(data, cb)
	req_id = req_id + 1
	req_cb[req_id] = cb
	local msg = data:encode(req_id)
	print("request " .. data.method)
	vim.api.nvim_call_function("chansend", {module.chan_id, msg})
end

function module.recieve(job_id, data, event)
	if data[1] == nil then
		return
	end

	o = json.decode(data)
	if o["error"] ~= nil then
		vim.api.nvim_err_writeln(inspect(o["error"]))
		return
	end

	if req_cb[o.id] == nil then
		return
	end

	req_cb[o.id](o)
	req_cb[o.id] = nil
end

function module.close()
	vim.api.nvim_call_function("chanclose", {module.chan_id})
end

return module
