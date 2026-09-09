-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local trimStart = require(script.Parent:WaitForChild("trimStart"))
local trimEnd = require(script.Parent:WaitForChild("trimEnd"))

return function(p1) --[[ Line: 4 | Upvalues: trimStart (copy), trimEnd (copy) ]]
	return trimStart(trimEnd(p1))
end