-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local __DEV__ = _G.__DEV__

require(script.Parent.Parent.Parent:WaitForChild("es7-types"))

return function(p1) --[[ Line: 7 | Upvalues: __DEV__ (copy) ]]
	if not __DEV__ then
		return table.isfrozen(p1)
	end

	print("Luau now has a direct table.isfrozen call that can save the overhead of this library function call")

	return table.isfrozen(p1)
end