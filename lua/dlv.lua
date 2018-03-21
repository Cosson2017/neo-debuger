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
local cmd = require("dlv.cmd")
local inspect = require("inspect")

local bpinfo = {}

-- following is callback ------------------------------
local function _set_breakpoint_cb(resp)
	print("set breakpoint resp", json.encode(resp))
end

local function _find_location_cb(resp)
	print("find loc resp", json.encode(resp))
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
	print("clear point resp", json.encode(resp))
end

local function _attach_cb(resp)
	print("attach resp", json.encode(resp))
end

local function _detach_cb(resp)
	print("detach resp", json.encode(resp))
end

local function _state_cb(resp)
	print("state resp", json.encode(resp))
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

--------continue------------------
local function _continue_cb(resp)
	print("continue resp", json.encode(resp))
end

local function _continue()
	local req = msg.command:new(cmd.Continue)
	job.send(req, _continue_cb)
end
----------------------------------
--
--halt/stop----------------------
local function _stop_cb(resp)
	print("stop ps resp", json.encode(resp))
end

local function _stop()
	local req = msg.command:new(cmd.Halt)
	job.send(req, _stop_cb)
end
---------------------------------
--
--step----------------------------
local function _step_cb(resp)
	print("step resp", json.encode(resp))
end

local function _step()
	local req = msg.command:new(cmd.Step)
	job.send(req, _step_cb)
end
----------------------------------
--
--next----------------------------
local function _next_cb(resp)
	print("next resp", json.encode(resp))
end

local function _next()
	local req = msg.command:new(cmd.Next)
	job.send(req, _next_cb)
end
----------------------------------
--
--step out---------------------------
local function _step_out_cb(resp)
	print("step out resp", json.encode(resp))
end

local function _step_out()
	local req = msg.command:new(cmd.StepOut)
	job.send(req, _step_out_cb)
end
-------------------------------------

module.set_breakpoint 	= _set_breakpoint
module.print_breakpoint = _print_breakpoint
module.Next				= _next
module.step 			= _step
module.step_out			= _step_out
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
module.stop				= _stop

return module
