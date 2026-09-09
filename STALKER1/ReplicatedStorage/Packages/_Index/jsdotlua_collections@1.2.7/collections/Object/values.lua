-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
require(script.Parent.Parent.Parent:WaitForChild("es7-types"))

return function(p1) --[[ Line: 5 ]]
	if p1 == nil then
		error("cannot extract values from a nil value")
	end

	local v1 = typeof(p1)
	local v2 = nil

	if v1 == "table" then
		local t = {}

		for k, v in pairs(p1) do
			table.insert(t, v)
		end

		return t
	end

	if v1 == "string" then
		local v3 = p1:len()

		v2 = table.create(v3)

		for i = 1, v3 do
			v2[i] = p1:sub(i, i)
		end
	end

	return v2
end