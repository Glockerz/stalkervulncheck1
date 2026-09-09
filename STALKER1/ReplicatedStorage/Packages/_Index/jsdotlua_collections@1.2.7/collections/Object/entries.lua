-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
require(script.Parent.Parent.Parent:WaitForChild("es7-types"))

return function(p1) --[[ Line: 6 ]]
	assert(p1 ~= nil, "cannot get entries from a nil value")

	local v2 = typeof(p1)
	local t = {}

	if v2 == "table" then
		for k, v in pairs(p1) do
			table.insert(t, { k, v })
		end
	elseif v2 == "string" then
		for i = 1, string.len(p1) do
			t[i] = { tostring(i), (string.sub(p1, i, i)) }
		end
	end

	return t
end