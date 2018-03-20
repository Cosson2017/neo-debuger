--------------------------------------------------
--    LICENSE: MIT
--     Author: Cosson2017
--    Version: 0.1
-- CreateTime: 2018-03-19 17:09:27
-- LastUpdate: 2018-03-19 17:09:27
--       Desc: 
--------------------------------------------------

local module = {}

local job = require("dlv.job")
local msg = require("dlv.msg")
local json = require("dlv.json")
local inspect = require("inspect")

local bpinfo = {}

-- following is callback ------------------------------
local function _set_breakpoint_cb(resp)
	print("set breakpoint resp", inspect(resp))
end

local function _find_location_cb(resp)
	print("set breakpoint resp", inspect(resp))
	local result = resp.result
	if result == nil then
		return
	end
	local loc = result.Locations
	if loc == nil then
		return
	end
	if loc[1] == nil then
		return
	end
	local pc = loc[1].pc
	if pc == nil then
		return
	end
	
	local req = msg.createBreakpoint:new(pc)
	job.send(req,_set_breakpoint_cb)
end

local function _clear_point_cb(resp)
	print("clear point resp", inspect(resp))
end

local function _attach_cb(resp)
	print("attach resp", inspect(resp))
end

local function _detach_cb(resp)
	print("detach resp", inspect(resp))
end

local function _state_cb(resp)
	print("state resp", inspect(resp))
end

-- following is request----------------------------------

-- 设置断点
local function _set_breakpoint(loc)
	local req = msg.findLocation:new(loc)
	job.send(req, _find_location_cb)
end

-- 清除断点
local function _clear_point(pointid)
	local req = msg.clearBreakpoint:new(pointid)
	job.send(req, _clear_point_cb)
end

-- 清除所有断点
local function _clear_all_point()
end

-- 打印所有断点
local function _print_breakpoint()
end

-- 下一步
local function _next()
end

local function _step()
end

-- 打印栈信息
local function _print_stack()
end

-- 打印变量
local function _print_var(var)
end

-- 打印本地变量
local function _print_locals_var()
end

-- 设置变量
local function _set_var(key, value)
end

-- 继续
local function _continue()
end

-- 带完善
local function _attach()
	local req = msg.attach:new()
	job.send(req, _attach_cb)
end

local function _detach()
	local req = msg.detach:new()
	job.send(req, _detach_cb)
end

local function _state()
	local req = msg.state:new()
	job.send(req, _state_cb)
end

module.set_breakpoint 	= _set_breakpoint
module.print_breakpoint = _print_breakpoint
module.nxt 				= _next
module.step 			= _step
module.print_stack 		= _print_stack
module.print_var 		= _print_var
module.print_locals 	= _print_locals_var
module.set_var 			= _set_var
module.continue 		= _continue
module.clear_point 		= _clear_point
module.clear_all 		= _clear_all_point
module.detach_ps 		= _detach
module.attach_ps 		= _attach
module.state 			= _state

return module
