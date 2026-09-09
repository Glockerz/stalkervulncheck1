-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
require(script.Parent.Parent.Parent.Parent:WaitForChild("es7-types"))

return function(p1, p2, p3) --[[ Line: 8 ]]
	if not p2 then
		return table.clone(p1._array)
	end

	local t = {}

	for v1, v2 in p1 do
		if p3 == nil then
			t[v1] = p2(v2, v1)

			continue
		end

		t[v1] = p2(p3, v2, v1)
	end

	return t
end