-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local Categories = script:WaitForChild("Categories")
local t = {}

for i, v in ipairs(Categories:GetChildren()) do
	if v:IsA("ModuleScript") then
		local v1 = require(v)

		if v1.RoundTypes then
			t.RoundTypes = v1.RoundTypes
		end

		if v1.MagFamilies then
			t.MagFamilies = v1.MagFamilies
		end

		for k, v2 in pairs(v1) do
			if k ~= "RoundTypes" and k ~= "MagFamilies" then
				if t[k] then
					warn(string.format("[ItemDatabase] duplicate item ID \'%s\' in module \'%s\' (overwriting)", k, v.Name))
				end

				t[k] = v2
			end
		end
	end
end

function t.GetItemData(p1) --[[ GetItemData | Line: 47 | Upvalues: t (copy) ]]
	local v1 = t[p1]

	if v1 then
		return v1
	end

	warn("Item ID not found in database: " .. tostring(p1))

	return {
		Name = "Unknown",
		ItemType = "General",
		ImageID = "",
		Size = Vector2.new(1, 1),
		BackgroundColor = Color3.fromRGB(100, 100, 100)
	}
end
function t.MagFits(p1, p2) --[[ MagFits | Line: 72 | Upvalues: t (copy) ]]
	if p1 == nil or p2 == nil then
		return false
	end

	if p1 == p2 then
		return true
	end

	local MagFamilies = t.MagFamilies

	if not MagFamilies then
		return false
	end

	local v1 = MagFamilies[p1]

	return if v1 == nil then false else v1 == MagFamilies[p2]
end

return t