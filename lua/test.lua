--------------------------------------------------
--    LICENSE: MIT
--     Author: Cosson2017
--    Version: 0.1
-- CreateTime: 2018-03-19 17:10:26
-- LastUpdate: 2018-03-19 17:10:26
--       Desc: 
--------------------------------------------------

local job = require("dlv.job")
local dlv = require("dlv")

if arg == 1 then
	job.connect("localhost", 10002)
elseif arg == 2 then
	dlv.set_breakpoint("main.go:25")
elseif arg == 3 then
	dlv.clear_point(1)
elseif arg == 4 then
	dlv.detach_ps()
elseif arg == 5 then
	dlv.attach_ps()
elseif arg == 6 then
	dlv.state()
elseif arg == 7 then
	dlv.continue()
elseif arg == 8 then
	dlv.Next()
elseif arg == 9 then
	dlv.step()
elseif arg == 10 then
	dlv.step_out()
elseif arg == 11 then
	dlv.stop()
elseif arg == 12 then
else
	print("please input op")
end

