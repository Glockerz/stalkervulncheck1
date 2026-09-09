-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
require(script.Parent.Parent.Parent.Parent:WaitForChild("es7-types"))

return function(p1, p2, p3) --[[ Line: 8 ]]
	if not p2 then
		return table.clone(p1)
	end

	local v1 = #p1
	local v3 = table.create(v1)

	for i = 1, v1 do
		if p3 == nil then
			v3[i] = p2(p1[i], i)

			continue
		end

		v3[i] = p2(p3, p1[i], i)
	end

	return v3
end