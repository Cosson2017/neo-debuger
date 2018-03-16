local module = {}

function module.json_decode(data)
  return vim.api.nvim_call_function('json_decode', {data})
end
function module.json_encode(data)
  return vim.api.nvim_call_function('json_encode', {data})
end

return module
