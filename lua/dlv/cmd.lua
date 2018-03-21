local module = {}
-- Continue resumes process execution.
module.Continue = "continue"
-- Rewind resumes process execution backwards (target must be a recording).
module.Rewind = "rewind"
-- Step continues to next source line, entering function calls.
module.Step = "step"
-- StepOut continues to the return address of the current function
module.StepOut = "stepOut"
-- SingleStep continues for exactly 1 cpu instruction.
module.StepInstruction = "stepInstruction"
-- Next continues to the next source line, not entering function calls.
module.Next = "next"
-- SwitchThread switches the debugger's current thread context.
module.SwitchThread = "switchThread"
-- SwitchGoroutine switches the debugger's current thread context to the thread running the specified goroutine
module.SwitchGoroutine = "switchGoroutine"
-- Halt suspends the process.
module.Halt = "halt"

return module
