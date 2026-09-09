-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local None = require(script.Parent.Parent:WaitForChild("Object"):WaitForChild("None"))

require(script.Parent.Parent.Parent:WaitForChild("es7-types"))

local function f1(p1, p2) --[[ Line: 5 ]]
	return type(p1) .. tostring(p1) < type(p2) .. tostring(p2)
end

return function(p1, p2) --[[ Line: 9 | Upvalues: f1 (copy), None (copy) ]]
	local v1 = f1

	if p2 ~= nil and p2 ~= None then
		if typeof(p2) ~= "function" then
			error("invalid argument to Array.sort: compareFunction must be a function")
		end

		v1 = function(p1, p22) --[[ Line: 16 | Upvalues: p2 (copy) ]]
			local v1 = p2(p1, p22)

			if typeof(v1) ~= "number" then
				error(("invalid result from compare function, expected number but got %s"):format((typeof(v1))))
			end

			return v1 < 0
		end
	end

	table.sort(p1, v1)

	return p1
end