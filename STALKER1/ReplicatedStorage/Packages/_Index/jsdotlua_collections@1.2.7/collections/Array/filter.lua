-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local __DEV__ = _G.__DEV__

require(script.Parent.Parent.Parent:WaitForChild("es7-types"))

return function(p1, p2, p3) --[[ Line: 10 | Upvalues: __DEV__ (copy) ]]
	if __DEV__ then
		if typeof(p1) ~= "table" then
			error(string.format("Array.filter called on %s", (typeof(p1))))
		end

		if typeof(p2) ~= "function" then
			error("callback is not a function")
		end
	end

	local v1 = #p1
	local t = {}
	local count = 1

	if p3 == nil then
		for i = 1, v1 do
			local v2 = p1[i]

			if v2 ~= nil and p2(v2, i, p1) then
				t[count] = v2
				count = count + 1
			end
		end
	else
		for j = 1, v1 do
			local v3 = p1[j]

			if v3 ~= nil and p2(p3, v3, j, p1) then
				t[count] = v3
				count = count + 1
			end
		end
	end

	return t
end