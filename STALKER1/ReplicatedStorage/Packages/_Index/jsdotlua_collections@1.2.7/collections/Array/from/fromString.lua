-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
require(script.Parent.Parent.Parent.Parent:WaitForChild("es7-types"))

return function(p1, p2, p3) --[[ Line: 8 ]]
	local v1 = #p1
	local v2 = table.create(v1)

	if p2 then
		local v3 = v2

		for i = 1, v1 do
			if p3 == nil then
				v3[i] = p2(string.sub(p1, i, i), i)

				continue
			end

			v3[i] = p2(p3, string.sub(p1, i, i), i)
		end

		return v3
	end

	local v4 = v2

	for j = 1, v1 do
		v4[j] = string.sub(p1, j, j)
	end

	return v4
end