-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
require(script.Parent.Parent.Parent:WaitForChild("es7-types"))

return function(p1, p2, p3) --[[ Line: 10 ]]
	local v1 = p3 or 1
	local v2 = #p1

	if v1 < 1 then
		v1 = math.max(v2 - math.abs(v1), 1)
	end

	for i = v1, v2 do
		if p1[i] == p2 then
			return i
		end
	end

	return -1
end