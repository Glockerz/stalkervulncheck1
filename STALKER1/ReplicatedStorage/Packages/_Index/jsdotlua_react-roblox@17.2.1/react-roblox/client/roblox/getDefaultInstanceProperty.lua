-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local v1 = require(script.Parent.Parent.Parent.Parent:WaitForChild("shared")).Symbol.named("Nil")
local t = {}

local function tryPropertyName(p1, p2) --[[ tryPropertyName | Line: 32 ]]
	return p1[p2]
end

return function(p1, p2) --[[ getDefaultInstanceProperty | Line: 36 | Upvalues: t (copy), v1 (copy), tryPropertyName (copy) ]]
	local v12 = t[p1]

	if v12 then
		local v2 = v12[p2]

		if v2 == v1 then
			return true, nil
		end

		if v2 ~= nil then
			return true, v2
		end
	else
		v12 = {}
		t[p1] = v12
	end

	local v3 = Instance.new(p1)
	local ok, result = pcall(tryPropertyName, v3, p2)

	v3:Destroy()

	if ok then
		if result == nil then
			v12[p2] = v1

			return ok, result
		end

		v12[p2] = result
	end

	return ok, result
end