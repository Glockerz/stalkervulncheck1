-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local Map = require(script.Parent:WaitForChild("Map"))
local v1 = require(script.Parent.Parent.Parent:WaitForChild("instance-of"))
local reduce = require(script.Parent.Parent:WaitForChild("Array"):WaitForChild("reduce"))

require(script.Parent.Parent.Parent:WaitForChild("es7-types"))

return function(p1) --[[ coerceToTable | Line: 9 | Upvalues: v1 (copy), Map (copy), reduce (copy) ]]
	if v1(p1, Map) then
		return reduce(p1:entries(), function(p1, p2) --[[ Line: 15 ]]
			p1[p2[1]] = p2[2]

			return p1
		end, {})
	end

	return p1
end