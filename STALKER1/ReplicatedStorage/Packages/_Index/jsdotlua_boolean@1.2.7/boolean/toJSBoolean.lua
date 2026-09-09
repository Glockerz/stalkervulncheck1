-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local number = require(script.Parent.Parent:WaitForChild("number"))

return function(p1) --[[ Line: 4 | Upvalues: number (copy) ]]
	return (p1 and true or false) and (if p1 == 0 or p1 == "" then false else not number.isNaN(p1))
end