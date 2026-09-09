-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
require(script.Parent.Parent.Parent:WaitForChild("es7-types"))

local map = require(script.Parent:WaitForChild("map"))

return function(p1, p2) --[[ Line: 5 | Upvalues: map (copy) ]]
	if #p1 == 0 then
		return ""
	end

	return table.concat(map(p1, function(p1) --[[ Line: 10 ]]
		return tostring(p1)
	end), p2 or ",")
end