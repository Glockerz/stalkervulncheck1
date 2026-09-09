-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local isInteger = require(script.Parent:WaitForChild("isInteger"))
local MAX_SAFE_INTEGER = require(script.Parent:WaitForChild("MAX_SAFE_INTEGER"))

return function(p1) --[[ Line: 5 | Upvalues: isInteger (copy), MAX_SAFE_INTEGER (copy) ]]
	return isInteger(p1) and math.abs(p1) <= MAX_SAFE_INTEGER
end