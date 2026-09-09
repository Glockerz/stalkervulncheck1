-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
require(script.Parent.Parent.Parent:WaitForChild("es7-types"))

return function(p1) --[[ preventExtensions | Line: 8 ]]
	local v1 = tostring(p1)

	return setmetatable(p1, {
		__metatable = false,
		__newindex = function(p1, p2, p3) --[[ __newindex | Line: 13 | Upvalues: v1 (copy) ]]
			error(("%q (%s) is not a valid member of %s"):format(tostring(p2), typeof(p2), v1), 2)
		end
	})
end