-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local objectIs = require(script.Parent:WaitForChild("objectIs"))

return function(p1, p2) --[[ shallowEqual | Line: 18 | Upvalues: objectIs (copy) ]]
	if objectIs(p1, p2) then
		return true
	end

	if typeof(p1) ~= "table" or (p1 == nil or (typeof(p2) ~= "table" or p2 == nil)) then
		return false
	end

	for v1, v2 in p1 do
		if not objectIs(p2[v1], v2) then
			return false
		end
	end

	for v3, v4 in p2 do
		if not objectIs(p1[v3], v4) then
			return false
		end
	end

	return true
end