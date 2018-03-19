--------------------------------------------------
--    LICENSE: MIT
--     Author: Cosson2017
--    Version: 0.1
-- CreateTime: 2018-03-19 17:09:49
-- LastUpdate: 2018-03-19 17:09:49
--       Desc: 
--------------------------------------------------

local module = {}

function module.decode(data)
  return vim.api.nvim_call_function('json_decode', {data})
end
function module.encode(data)
  return vim.api.nvim_call_function('json_encode', {data})
end

return module
