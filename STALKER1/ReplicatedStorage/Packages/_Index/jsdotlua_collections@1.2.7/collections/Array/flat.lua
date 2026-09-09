-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local __DEV__ = _G.__DEV__
local isArray = require(script.Parent:WaitForChild("isArray"))

require(script.Parent.Parent.Parent:WaitForChild("es7-types"))

local function v1(p1, p2) --[[ flat | Line: 5 | Upvalues: __DEV__ (copy), isArray (copy), v1 (copy) ]]
	if __DEV__ then
		if typeof(p1) ~= "table" then
			error(string.format("Array.flat called on %s", (typeof(p1))))
		end

		if p2 ~= nil and typeof(p2) ~= "number" then
			error("depth is not a number or nil")
		end
	end

	local v12 = p2 or 1
	local t = {}

	for v2, v3 in p1 do
		if isArray(v3) then
			for v5, v6 in if v12 > 1 then v1(v3, v12 - 1) else v3 do
				table.insert(t, v6)
			end

			continue
		end

		table.insert(t, v3)
	end

	return t
end

return v1