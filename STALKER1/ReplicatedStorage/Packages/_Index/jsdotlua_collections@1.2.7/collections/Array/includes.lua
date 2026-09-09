-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
require(script.Parent.Parent.Parent:WaitForChild("es7-types"))

local indexOf = require(script.Parent:WaitForChild("indexOf"))

return function(p1, p2, p3) --[[ Line: 5 | Upvalues: indexOf (copy) ]]
	return indexOf(p1, p2, p3) ~= -1
end