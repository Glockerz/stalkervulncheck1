-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local Set = require(script.Parent.Parent:WaitForChild("Set"))

require(script.Parent.Parent.Parent:WaitForChild("es7-types"))

local v1 = require(script.Parent.Parent.Parent:WaitForChild("instance-of"))

return function(p1) --[[ Line: 8 | Upvalues: v1 (copy), Set (copy) ]]
	if p1 == nil then
		error("cannot extract keys from a nil value")
	end

	local v12 = typeof(p1)
	local v2 = nil

	if v12 == "table" then
		local t = {}

		if v1(p1, Set) then
			return t
		end

		for k in pairs(p1) do
			table.insert(t, k)
		end

		return t
	end

	if v12 == "string" then
		local v3 = p1:len()

		v2 = table.create(v3)

		for i = 1, v3 do
			v2[i] = tostring(i)
		end
	end

	return v2
end