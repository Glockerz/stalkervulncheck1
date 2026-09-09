-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local __DEV__ = _G.__DEV__
local flat = require(script.Parent:WaitForChild("flat"))
local map = require(script.Parent:WaitForChild("map"))

require(script.Parent.Parent.Parent:WaitForChild("es7-types"))

return function(p1, p2, p3) --[[ flatMap | Line: 9 | Upvalues: __DEV__ (copy), flat (copy), map (copy) ]]
	if __DEV__ then
		if typeof(p1) ~= "table" then
			error(string.format("Array.flatMap called on %s", (typeof(p1))))
		end

		if typeof(p2) ~= "function" then
			error("callback is not a function")
		end
	end

	return flat(map(p1, p2, p3))
end