-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local Map = require(script.Parent:WaitForChild("Map"))
local Object = require(script.Parent.Parent:WaitForChild("Object"))
local v1 = require(script.Parent.Parent.Parent:WaitForChild("instance-of"))

require(script.Parent.Parent.Parent:WaitForChild("es7-types"))

return function(p1) --[[ coerceToMap | Line: 9 | Upvalues: v1 (copy), Map (copy), Object (copy) ]]
	return if v1(p1, Map) and p1 then p1 else Map.new(Object.entries(p1))
end