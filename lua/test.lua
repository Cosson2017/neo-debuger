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

--job.connect("localhost", 10002)
dlv.set_breakpoint("main.go:17")
