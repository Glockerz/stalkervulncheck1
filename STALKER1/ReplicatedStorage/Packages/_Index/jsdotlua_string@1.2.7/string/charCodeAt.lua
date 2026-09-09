-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local NaN = require(script.Parent.Parent:WaitForChild("number")).NaN

return function(p1, p2) --[[ Line: 7 | Upvalues: NaN (copy) ]]
	if type(p2) ~= "number" then
		p2 = 1
	end

	local v1 = string.len(p1)

	if p2 < 1 or v1 < p2 then
		return NaN
	end

	local v2 = utf8.offset(p1, p2)

	if v2 == nil or v1 < v2 then
		return NaN
	end

	local v3 = utf8.codepoint(p1, v2, v2)

	if v3 == nil then
		return NaN
	end

	return v3
end