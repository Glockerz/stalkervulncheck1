-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local console = require(script.Parent:WaitForChild("console"))
local t = {}

setmetatable(t, {
	__metatable = "UninitializedState",
	__index = function(p1, p2) --[[ __index | Line: 23 | Upvalues: console (copy) ]]
		if not _G.__DEV__ then
			return nil
		end

		console.warn("Attempted to access uninitialized state. Use setState to initialize state")

		return nil
	end,
	__newindex = function(p1, p2) --[[ __newindex | Line: 31 | Upvalues: console (copy) ]]
		if not _G.__DEV__ then
			return nil
		end

		console.error("Attempted to directly mutate state. Use setState to assign new values to state.")

		return nil
	end,
	__tostring = function(p1) --[[ __tostring | Line: 39 ]]
		return "<uninitialized component state>"
	end
})

return t