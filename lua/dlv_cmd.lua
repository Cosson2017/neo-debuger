local module = {}

local function _set_breakpoint()
end

local function _clear_point()
end

local function _clear_all_point()
end

local function _print_breakpoint()
end

local function _next()
end

local function _step()
end

local function _print_stack()
end

local function _print_var(var)
end

local function _print_locals_var()
end

local function _set_var(key, value)
end

local function _continue()
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

return module
