-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local __DEV__ = _G.__DEV__
local isArray = require(script.Parent:WaitForChild("isArray"))

require(script.Parent.Parent.Parent:WaitForChild("es7-types"))

return function(p1, ...) --[[ concat | Line: 12 | Upvalues: isArray (copy), __DEV__ (copy) ]]
	local v1 = 0
	local count, v2

	if isArray(p1) then
		count, v2 = #p1, table.clone(p1)
	else
		count = v1 + 1
		v2 = {
			[count] = p1
		}
	end

	for i = 1, select("#", ...) do
		local v4 = select(i, ...)
		local v5 = typeof(v4)

		if v4 ~= nil then
			if v5 == "table" then
				if __DEV__ and not isArray(v4) then
					error("Array.concat(...) only works with array-like tables but it received an object-like table.\nYou can avoid this error by wrapping the object-like table into an array. Example: `concat({1, 2}, {a = true})` should be `concat({1, 2}, { {a = true} }`")
				end

				for j = 1, #v4 do
					count = count + 1
					v2[count] = v4[j]
				end

				continue
			end

			count = count + 1
			v2[count] = v4
		end
	end

	return v2
end