--------------------------------------------------
--    LICENSE: MIT
--     Author: Cosson2017
--    Version: 0.1
-- CreateTime: 2018-03-19 17:10:06
-- LastUpdate: 2018-03-19 17:35:30
--       Desc: 
--------------------------------------------------

local module = {}

local json = require("dlv.json")

local jsonRequestObject = {
	jsonrpc	= "2.0",
}
function jsonRequestObject:new()
	local o = {}
	o.jsonrpc = self.jsonrpc

	setmetatable(o, {__index = self})
	return o
end

local function json_encode(o, id)
	local obj = {}
	obj.id = id
	obj.jsonrpc = o.jsonrpc
	obj.method = o.method
	obj.params = o.params
	return json.encode(obj)
end

-- 发现位置
module.findLocation = {}
function module.findLocation:new(loc)
	local o = jsonRequestObject:new()
	setmetatable(o, { __index = self })

	o.method = "RPCServer.FindLocation"
	o.params = {
		{
			Scope = {GoroutineID = -1, Frame = 0},
			Loc = loc,
		}
	}

	o.encode = json_encode

	return o
end

-- 创建断点
module.createBreakpoint = {}
function module.createBreakpoint:new(addr)
	local o = jsonRequestObject:new()
	setmetatable(o, { __index = self })

	o.method = "RPCServer.CreateBreakpoint"
	o.params = {
		{
			Breakpoint = {addr = addr},
		}
	}

	o.encode = json_encode

	return o
end

-- 清除断点
module.clearBreakpoint = {}
function module.clearBreakpoint:new(id)
	local o = jsonRequestObject:new()
	setmetatable(o, {__index = self})
	o.method = "RPCServer.ClearBreakpoint"
	o.params = {
		{
			Id = id,
		}
	}

	o.encode = json_encode
	return o
end

module.attach = {}
function module.attach:new()
	local o = jsonRequestObject:new()
	setmetatable(o, {__index = self})
	o.method = "RPCServer.AttachedToExistingProcess"
	o.params = {
		{
		}
	}
	o.encode = json_encode
	return o
end

-- detach
module.detach = {}
function module.detach:new()
	local o = jsonRequestObject:new()
	setmetatable(o, {__index = self})
	o.method = "RPCServer.Detach"
	o.params = {
		{
			Kill = false,
		}
	}
	o.encode = json_encode
	return o
end

module.state = {}
function module.state:new()
	local o = jsonRequestObject:new()
	setmetatable(o, {__index = self})
	o.method = "RPCServer.State"
	o.params = {
		{
		}
	}
	o.encode = json_encode
	return o
end

return module
